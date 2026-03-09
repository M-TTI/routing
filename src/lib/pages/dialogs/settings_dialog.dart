import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/viewmodels/settings_viewmodel.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late final TextEditingController _osuPathController;

  @override
  void initState() {
    super.initState();

    _osuPathController = TextEditingController(
        text: context.read<SettingsViewModel>().osuPath ?? '',
    );
  }

  @override
  void dispose() {
    _osuPathController.dispose();
    super.dispose();
  }

  Future<void> _browsePath() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.single.path != null) {
      _osuPathController.text = result.files.single.path!;
    }
  }

  void _save() {
    context.read<SettingsViewModel>().setOsuPath(_osuPathController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();

    return AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('osu! executable path'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _osuPathController,
                  builder: (context, value, _) => TextField(
                    controller: _osuPathController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '/path/to/osu!',
                      helperText: value.text.endsWith('.AppImage')
                          ? 'AppImage paths may need to be reset after updates'
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              BaseButton(
                onPressed: _browsePath,
                icon: t.folderOpenIcon,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Theme'),
          const SizedBox(height: 8),
          DropdownButton<ThemeMode>(
            value: viewModel.themeMode,
            onChanged: (value) => viewModel.setThemeMode(value!),
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            ],
          ),
        ],
      ),
      actions: [
        BaseButton(
          onPressed: _save,
          icon: t.saveIcon,
          label: 'Save',
        ),
      ],
    );
  }
}