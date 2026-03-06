import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_archive/flutter_archive.dart';

class SkinImporter {
  static Future<List<File>> _selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, allowedExtensions: ['.osk', '.zip']);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      return files;
    }

    return List.empty();
  }

  static Future<bool> _extractFile(File file, Directory targetDir) async {
    try {
      ZipFile.extractToDirectory(zipFile: file, destinationDir: targetDir);
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> _saveFile(File file, Directory tmpDir) async {
    // Moves the archive to the tmp dir
    await file.rename(p.join(tmpDir.path, p.basename(file.path)));
    Directory tmpExtract = await Directory(p.join(tmpDir.path, 'extract')).create();

  }

  static Future<void> importFiles() async {
    List<File> files = await _selectFiles();

    if (files.isEmpty) {
      return;
    }

    Directory tmpDir = await getTemporaryDirectory();
    // Tout s'effectue dans tmpRoutingDir
    Directory tmpRoutingDir = await Directory(p.join(tmpDir.path, 'Routing')).create();


  }
}