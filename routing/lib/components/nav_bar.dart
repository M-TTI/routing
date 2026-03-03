import 'package:flutter/material.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/themes/theme.dart' as t;

class NavBar extends StatelessWidget {
  const NavBar({required this.title, required this.isSmall, super.key});

  final String title;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: t.shadow,
          )
        ],
      ),

      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Spacer(),
          BaseButton( // Add Button
            onPressed: () {},
            icon: Icons.add_circle_outline,
            label: isSmall ? null : 'Add a skin',
          ),
          SizedBox(width: 8),
          BaseButton( // Menu Button
            onPressed: () {},
            icon: Icons.menu,
            label: isSmall ? null : 'Menu',
          )
        ],
      )
    );
  }
}