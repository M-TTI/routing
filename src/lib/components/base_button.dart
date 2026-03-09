import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({required this.icon, this.label, required this.onPressed, super.key});

  final IconData icon;
  final String? label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final button = label == null
        ? FilledButton(
            onPressed: onPressed,
            child: Icon(icon),
          )
        : FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label!),
          );

    return button;
  }
}