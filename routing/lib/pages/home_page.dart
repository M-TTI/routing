import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:routing/components/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final isSmall = MediaQuery.of(context).size.width < 600;

    return SafeArea(
      child: Material(
        child: Column(
          children: [
            NavBar(title: widget.title, isSmall: isSmall),
            const Expanded(child: Center(child: Text('HelloWorld!'))),
          ],
        ),
      ),
    );
  }
}