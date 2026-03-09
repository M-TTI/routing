import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/viewmodels/home_viewmodel.dart';
import 'package:routing/viewmodels/settings_viewmodel.dart';

class NavBar extends StatelessWidget {
  const NavBar({required this.title, required this.isSmall, super.key});

  final String title;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel home = context.watch<HomeViewModel>();

    final menuWidth = isSmall ? 120.0 : 240.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: 64,
      padding: EdgeInsets.only(
        left: 8,
        right: home.menuOpen ? menuWidth + 8 : 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: t.shadow,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(width: 8),
          FilledButton( // Theme Button
            child: Icon(Icons.brightness_2),
            onPressed: () {
              final settingsViewModel = context.read<SettingsViewModel>();
              settingsViewModel.setThemeMode(
                settingsViewModel.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
          Spacer(),
          if (!home.menuOpen) ...[
            BaseButton( // Add Button
              onPressed: () => context.read<HomeViewModel>().importFiles(),
              icon: t.addIcon,
              label: isSmall ? null : 'Add a skin',
            ),
            SizedBox(width: 8),
          ],
          BaseButton( // Menu Button
            onPressed: () => context.read<HomeViewModel>().toggleMenu(),
            icon: t.menuIcon,
            label: isSmall ? null : 'Menu',
          ),
        ],
      ),
    );
  }
}
