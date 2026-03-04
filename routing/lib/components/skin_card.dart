import 'dart:io';

import 'package:flutter/material.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/themes/theme.dart' as t;

class SkinCard extends StatelessWidget {
  const SkinCard({required this.isSmall, super.key});

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    String? imagePath = null;
    Widget card;

    Widget imageArea(double size) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imagePath != null
            ? Image.file(
                File(imagePath),
                width: size,
                height: size,
                fit: BoxFit.cover
        )
            : Container(width: size, height: size, color: t.placeholder),
      );
    }

    final decoration = BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: t.cardShadow,
    );

    if (isSmall) {
      card = SizedBox(
        width: 160,
        height: 200,
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              imageArea(140),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BaseButton(
                    onPressed: () {},
                    icon: Icons.open_in_new_outlined
                  ),
                  SizedBox(height: 8),
                  BaseButton(
                    onPressed: () {},
                    icon: Icons.download_outlined
                  ),
                ],
              ),
            ],
          ),
        ),
      );

    } else {
      card = SizedBox(
        width: 280,
        height: 360,
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              imageArea(260),
              Spacer(),
              BaseButton(
                onPressed: () {},
                icon: Icons.open_in_new_outlined,
                label: 'Open with Osu!'
              ),
              SizedBox(height: 8),
              BaseButton(
                onPressed: () {},
                icon: Icons.download_outlined,
                label: 'Download Skin',
              ),
            ],
          ),
        ),
      );
    }

    return card;
  }
}