import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/databases/database.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/viewmodels/home_viewmodel.dart';
import 'package:path/path.dart' as p;

class SkinCard extends StatelessWidget {
  const SkinCard({required this.skin, required this.isSmall, super.key});

  final Skin skin;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();

    final Widget card;

    ClipRRect imageArea(double size) {
      final File previewFile = File(p.join(
        skin.assetsPath,
        isSmall ? 'sm_preview.png' : 'preview.png',
      ));

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: previewFile.existsSync()
            ? Image.file(
                previewFile,
                width: size,
                height: size,
                fit: BoxFit.cover
              )
            : Container(
                width: size,
                height: size,
                color: t.placeholder
              ),
      );
    }

    AlertDialog skinDeleteDialog() {
      return AlertDialog(
        title: const Text('Delete skin'),
        content: Text('Are you sure you want to delete "${skin.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
          ),
        ],
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
        height: 240,
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  imageArea(140),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: BaseButton( // Delete Button
                      onPressed: () async {
                        final confirmed = await showDialog(
                          context: context,
                          builder: (context) => skinDeleteDialog(),
                        );

                        if (confirmed == true) {
                          homeViewModel.deleteSkin(skin);
                        }
                      },
                      icon: t.trashIcon,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(skin.name),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BaseButton( // Open with Buton
                    onPressed: () => homeViewModel.openWithOsu([skin]),
                    icon: t.openInIcon
                  ),
                  SizedBox(height: 8),
                  BaseButton( // Download Button
                    onPressed: () => homeViewModel.downloadSkin(skin),
                    icon: t.downloadIcon
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
        height: 400,
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  imageArea(260),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: BaseButton( // Delete Button
                      onPressed: () async {
                        final confirmed = await showDialog(
                            context: context,
                            builder: (context) => skinDeleteDialog(),
                        );

                        if (confirmed == true) {
                          homeViewModel.deleteSkin(skin);
                        }
                      },
                      icon: t.trashIcon,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(skin.name),
              SizedBox(height: 8),
              BaseButton( // Open with Button
                onPressed: () => homeViewModel.openWithOsu([skin]),
                icon: Icons.open_in_new_outlined,
                label: 'Open with Osu!'
              ),
              SizedBox(height: 8),
              BaseButton( // Download Button
                onPressed: () => homeViewModel.downloadSkin(skin),
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