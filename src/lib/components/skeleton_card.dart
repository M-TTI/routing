import 'package:flutter/material.dart';
import 'package:routing/themes/theme.dart' as t;

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({required this.isSmall, super.key});

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    Widget card;

    Widget imageArea(double size) {
      return Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? t.skeleton : t.skeletonDark,
          borderRadius: BorderRadius.circular(8),
        ),
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
              imageArea(140),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 52, height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    width: 52, height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
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
              imageArea(260),
              Spacer(),
              Container(
                width: 172, height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 172, height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return card;
  }
}