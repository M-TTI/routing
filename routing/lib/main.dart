import 'package:flutter/material.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/pages/home_page.dart';

void main() {
  runApp(const RoutingApp());
}

final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

class RoutingApp extends StatelessWidget {
  const RoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeModeNotifier,
      builder: (context, _) => MaterialApp(
        title: 'Routing',
        theme: t.buildTheme(Brightness.light),
        darkTheme: t.buildTheme(Brightness.dark),
        themeMode: themeModeNotifier.value,
        home: const HomePage(title: 'Routing'),
      ),
    );
  }
}


