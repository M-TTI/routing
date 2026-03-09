import 'dart:io';
import 'dart:ui' as ui;
import 'package:drift/drift.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:routing/databases/database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';


class SkinService {
  SkinService({required this.db});

  final AppDataBase db;

  ///
  /// Private methods
  ///

  static Future<List<File>> _selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['osk', 'zip']
    );

    if (result == null) {
      return List<File>.empty();
    }

    return result.paths.map((path) => File(path!)).toList();
  }

  static Future<bool> _extractFile(File file, Directory targetDir) async {
    try {
      final bytes = await file.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final entry in archive) {
        final entryPath = p.join(targetDir.path, entry.name);
        if (entry.isFile) {
          final outFile = File(entryPath);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(entry.content as List<int>);
        } else {
          await Directory(entryPath).create(recursive: true);
        }
      }

      return true;
    } catch (e) {
      return false;
    }

  }

  /// Check if skin.ini exists to decide if it is a valid skin.
  /// If yes, then we extract data from it.
  static Future<Map<String, String>?> _parseSkinIni(Directory extractDir) async {
    final skinIni = File(p.join(extractDir.path, 'skin.ini'));
    if (!await skinIni.exists()) {
      return null;
    }

    String name = 'Unknown';
    String author = 'Unknown';
    String hitCirclePrefix = 'default';
    String comboPrefix = '';
    bool inFontsSection = false;

    for (final line in await skinIni.readAsLines()) {
      final trimmed = line.trim();

      // Skipping comments
      if (trimmed.isEmpty || trimmed.startsWith('//')) continue;

      if (trimmed == '[Fonts]') { // We are in fonts section, we can parse for HitCirclePrefix
        inFontsSection = true;
      } else if (trimmed.startsWith('[')) { // We are not in fonts section anymore so we can stop parsing for HitCirclePrefix
        inFontsSection = false;
      }

      if (trimmed.startsWith('Name:')) {
        name = trimmed.substring(6);
      }

      if (trimmed.startsWith('Author:')) {
        author = trimmed.substring(8).trim();
      }

      if (inFontsSection && trimmed.startsWith('HitCirclePrefix:')) {
        hitCirclePrefix = trimmed
            .substring('HitCirclePrefix:'.length)
            .trim()
            .replaceAll('/', p.separator); // Ensure windows file system compatibility
      }

      if (inFontsSection && trimmed.startsWith('ComboPrefix:')) {
        comboPrefix = trimmed
            .substring('ComboPrefix:'.length)
            .trim()
            .replaceAll('/', p.separator); // Ensure windows file system compatibility
      }
    }
    return { 'name': name, 'author': author, 'hitCirclePrefix': hitCirclePrefix, 'comboPrefix': comboPrefix };
  }

  static Future<Directory> _getOrCreateRoutingDir() async {
    final supportDir = await getApplicationSupportDirectory();

    if (!await File(p.join(supportDir.path, 'README')).exists()) {
      await File(p.join(supportDir.path, 'README')).writeAsString(
        'This folder contains asset for the skins managed by this application.\n Do not modify its contents (or do if you want things to break, not my problem).',
      );
    }

    return supportDir;
  }

  Future<bool> _processFile(File file, Directory tmpRoutingDir) async {
    // Move archive into tmp/Routing
    final String archiveName = p.basenameWithoutExtension(file.path);
    final File archive = await file.copy(p.join(tmpRoutingDir.path, p.basename(file.path)));
    await file.delete();

    // Extract into a per-file sub-dir, returns false if fails
    final Directory extractDir = await Directory(p.join(tmpRoutingDir.path, '${archiveName}_extract')).create();
    if (!await _extractFile(archive, extractDir)) {
      await extractDir.delete(recursive: true);

      return false;
    }

    // Validate and get skin infos
    final Map<String, String>? skinInfo = await _parseSkinIni(extractDir);
    if (skinInfo == null) {
      await extractDir.delete(recursive: true);

      return false;
    }

    // Get skin size in Mb
    final double sizeMb = await archive.length() / (1024 * 1024);

    // Insert with placeholder assetsPath to get the id
    final int id = await db.insertSkin(SkinsCompanion(
      name: Value(skinInfo['name']!),
      author: Value(skinInfo['author']!),
      assetsPath: Value(''),
      size: Value(sizeMb),
    ));

    // Build final skin folder: [SupportDir]/routing/{id}
    // SupportDir would be %AppData%/local/routing for windows or ~/.local/share/routing for linux.
    final routingDir = await _getOrCreateRoutingDir();
    final skinDir = await Directory(p.join(routingDir.path, '$id')).create();

    // Move archive and assets into place
    await archive.copy(p.join(skinDir.path, 'archive.osk'));
    await archive.delete();
    
    final String hitCirclePrefix = skinInfo['hitCirclePrefix']!;
    final String comboPrefix = skinInfo['comboPrefix']!;
    await _generatePreview(extractDir, hitCirclePrefix, comboPrefix, p.join(skinDir.path, 'preview.png'), 260);
    await _generatePreview(extractDir, hitCirclePrefix, comboPrefix, p.join(skinDir.path, 'sm_preview.png'), 140);

    // Update DB with real assetsPath
    await db.updateSkinAssetsPath(id, skinDir.path);

    return true;
  }

  static File? _findPngAsset(Directory dir, String name) {
    // Look for @2x (larger) asset
    final x2 = File(p.join(dir.path, '$name@2x.png'));

    if (x2.existsSync()) {
      return x2;
    }

    // Fallback to default asset
    final x1 = File(p.join(dir.path, '$name.png'));

    if (x1.existsSync()) {
      return x1;
    }

    return null;
  }

  static Future<ui.Image?> _loadImage(File? file) async {
    if (file == null) {
      return null;
    }

    final Uint8List bytes = await file.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();

    return frame.image;
  }

  static Future<void> _generatePreview(
    Directory extractDir,
    String hitCirclePrefix,
    String comboPrefix,
    String outputPath,
    int size,
  ) async {
    final ui.Image? hitCircle = await _loadImage(_findPngAsset(extractDir, 'hitcircle'));
    final ui.Image? overlay = await _loadImage(_findPngAsset(extractDir, 'hitcircleoverlay'));

    ui.Image? number = await _loadImage(_findPngAsset(extractDir, '$hitCirclePrefix-1'));
    if (number == null && comboPrefix.isNotEmpty) {
      number = await _loadImage(_findPngAsset(extractDir, '$comboPrefix-1'));
    }

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);
    final ui.Rect dst = ui.Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());

    void drawLayer(ui.Image? img) {
      if (img == null) {
        return;
      }
      canvas.drawImageRect(
        img,
        ui.Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble()),
        dst,
        ui.Paint(),
      );
    }

    drawLayer(hitCircle);
    drawLayer(overlay);
    if (number != null) {
      final double numberSize = size * 0.5;
      final double offset = (size - numberSize) / 2;
      canvas.drawImageRect(
        number,
        ui.Rect.fromLTWH(0, 0, number.width.toDouble(), number.height.toDouble()),
        ui.Rect.fromLTWH(offset, offset, numberSize, numberSize),
        ui.Paint(),
      );
    }

    final ui.Image image = await recorder.endRecording().toImage(size, size);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    await File(outputPath).writeAsBytes(bytes!.buffer.asUint8List());
  }

  ///
  /// Public methods
  ///

  // Entry point of the import process
  Future<void> importFiles() async {
    final List<File> files = await _selectFiles();

    if (files.isEmpty) return;

    final Directory tmpDir = await getTemporaryDirectory();
    final Directory tmpRoutingDir = await Directory(p.join(tmpDir.path, 'routing')).create();

    final List<File> unprocessedFiles = List.from(files);

    try {
      for (final file in files) {
        await _processFile(file, tmpRoutingDir);

        unprocessedFiles.remove(file);
      }

      await LocalNotification(
        title: 'Import Successful',
        body: 'All skins were imported successfully.'
      ).show();

    } catch (e) {
      await LocalNotification(
        title: 'Failed to import skin',
        body: 'Could not import: "${unprocessedFiles.map((f) => p.basename(f.path)).join(', ')}".',
      ).show();

    } finally {
      // Clean tmpDir
      if (await tmpRoutingDir.exists()) {
        await tmpRoutingDir.delete(recursive: true);
      }
    }
  }

  Future<void> openWithOsu(List<Skin> skins, String osuPath) async {
    final List<String> skinPaths = [];

    for (final skin in skins) {
      // Get the stored skin archive.osk
      File archive = File(p.join(skin.assetsPath, 'archive.osk'));
      // Get a copy of the skin archive named after the skin name, to be opened by osu!
      File archiveCpy = await archive.copy(p.join(skin.assetsPath, '${skin.name}.osk'));

      skinPaths.add(archiveCpy.path);
    }

    await Process.start(osuPath, skinPaths, mode: ProcessStartMode.detached);
  }

  Future<void> downloadSkin(Skin skin) async {
    final String? savePath = await FilePicker.platform.saveFile(
      fileName: '${skin.name}.osk',
      type: FileType.custom,
      allowedExtensions: ['osk'],
    );

    if (savePath == null) return;

    try {
      final File archive = File(p.join(skin.assetsPath, 'archive.osk'));
      await archive.copy(savePath);

      await LocalNotification(
        title: 'Download complete',
        body: '"${skin.name}" has been saved.',
      ).show();

    } catch (e) {
      await LocalNotification(
        title: 'Failed to download skin',
        body: '"${skin.name}" could not be saved.',
      ).show();
    }
  }

  Future<void> deleteSkin(Skin skin) async {
    final Directory skinDir = Directory(skin.assetsPath);
    try {
      await skinDir.delete(recursive: true);
      await db.deleteSkinById(skin.id);

      await LocalNotification(
        title: 'Deletion complete',
        body: '"${skin.name}" has been deleted.',
      ).show();

    } catch (e) {
      await LocalNotification(
        title: 'Failed to delete skin',
        body: '"${skin.name}" could not be deleted.',
      ).show();
    }
  }
}