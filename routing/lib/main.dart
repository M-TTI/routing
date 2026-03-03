import 'package:flutter/material.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/pages/home_page.dart';

void main() {
  runApp(const RoutingApp());
}

class RoutingApp extends StatelessWidget {
  const RoutingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routing',
      theme: t.buildTheme(Brightness.light),
      darkTheme: t.buildTheme(Brightness.dark),
      home: const HomePage(title: 'Routing'),
    );
  }
}


