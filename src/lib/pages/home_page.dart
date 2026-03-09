import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/components/nav_bar.dart';
import 'package:routing/components/side_menu.dart';
import 'package:routing/components/skeleton_card.dart';
import 'package:routing/components/skin_card.dart';
import 'package:routing/databases/database.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/viewmodels/home_viewmodel.dart';
import 'package:routing/viewmodels/settings_viewmodel.dart';
import 'package:routing/pages/dialogs/osu_path_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.read<SettingsViewModel>().osuPathConfigured) {
        showDialog(
            context: context,
            builder: (_) => const OsuPathDialog(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    final isSmall = MediaQuery.of(context).size.width < 600;
    final menuWidth = isSmall ? 120.0 : 240.0;

    final listingBody = StreamBuilder<List<Skin>>(
      stream: homeViewModel.skins,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Wrap(
            spacing: 32,
            runSpacing: 32,
            children: List.generate(4, (_) => SkeletonCard(isSmall: isSmall)),
          );
        }

        final skins = snapshot.data!;
        if (skins.isEmpty) {
          return Center(child: Text('No skin to display!'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 32,
            runSpacing: 32,
            children: skins.map((s) => SkinCard(skin: s, isSmall: isSmall)).toList(),
          ),
        );
      },
    );

    return SafeArea(
      child: Material(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Column(
              children: [
                NavBar(title: widget.title, isSmall: isSmall),
                Expanded( // Body
                  child: listingBody,
                ),
              ],
            ),
            if (homeViewModel.menuOpen)
              Positioned(
                top: 64,
                left: 0,
                right: 0,
                bottom: 0,
                child : GestureDetector(
                  onTap: () => context.read<HomeViewModel>().closeMenu(),
                  child: Container(color: t.shadow),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              top: 0,
              bottom: 0,
              right: homeViewModel.menuOpen ? 0 : -menuWidth,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: homeViewModel.menuOpen ? 1.0 : 0.0,
                child: SideMenu(isSmall: isSmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
