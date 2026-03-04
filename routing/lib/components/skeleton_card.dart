import 'package:flutter/material.dart';
import 'package:routing/components/base_button.dart';
import 'package:routing/themes/theme.dart' as t;

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({required this.isSmall, super.key});

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    Widget card;
    if (isSmall) {
      card = Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // TODO: add image skeleton
            Row(
              children: [
                BaseButton( // TODO: Add Button Skeleton
                  onPressed: () {},
                  icon: Icons.open_in_new_outlined
                ),
                BaseButton( // TODO: Add Button Skeleton
                  onPressed: () {},
                  icon: Icons.download_outlined
                )
              ],
            )
          ],
        ),
      );

    } else {
      card = Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // TODO: add image skeleton
              BaseButton( // TODO: Add Button Skeleton
                  onPressed: () {},
                  icon: Icons.open_in_new_outlined,
                  label: 'Open with Osu!'
              ),
              BaseButton( // TODO: Add Button Skeleton
                  onPressed: () {},
                  icon: Icons.download_outlined,
                  label: 'Download Skin',
              )
            ],
          ),
      );
    }

    return card;
  }
}