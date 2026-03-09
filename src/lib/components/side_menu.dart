import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/pages/dialogs/settings_dialog.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/viewmodels/home_viewmodel.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({required this.isSmall, super.key});

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();

    return Container(
      width: isSmall ? 120 : 240,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            offset: Offset(-4, 0),
            blurRadius: 8,
            color: t.shadow,
          )
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseButton( // TODO: Add Button
            onPressed: () => homeViewModel.importFiles(),
            icon: t.addIcon,
            label: isSmall ? null : 'Add a skin',
          ),
          SizedBox(height: 8),
          BaseButton( // TODO: Open all with Button
            onPressed: () => homeViewModel.openAllWithOsu(),
            icon: t.openInIcon,
            label: isSmall ? null : 'Open all with Osu!',
          ),
          SizedBox(height: 8),
          BaseButton( // TODO: Settings Button
            onPressed: () {
              homeViewModel.closeMenu();
              showDialog(
                  context: context, 
                  builder: (_) => const SettingsDialog(),
              );
            },
            icon: t.settingsIcon,
            label: isSmall ? null : 'settings',
          ),
        ],
      ),
    );
  }
}