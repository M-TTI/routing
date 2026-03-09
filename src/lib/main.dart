import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/databases/database.dart';
import 'package:routing/services/settings_service.dart';
import 'package:routing/themes/theme.dart' as t;
import 'package:routing/pages/home_page.dart';
import 'package:routing/viewmodels/home_viewmodel.dart';
import 'package:routing/viewmodels/settings_viewmodel.dart';
import 'package:local_notifier/local_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SettingsService settings = await SettingsService.load();
  final AppDataBase db = AppDataBase();

  await localNotifier.setup(appName: 'Routing');

  runApp(
    // Dependency Injection with provider.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsViewModel(settings)),
        ChangeNotifierProvider(create: (_) => HomeViewModel(db: db, settingsService: settings)),
      ],
      child: const RoutingApp(),
    ),
  );
}

class RoutingApp extends StatelessWidget {
  const RoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = context.watch<SettingsViewModel>().themeMode;

    return MaterialApp(
      title: 'Routing',
      theme: t.buildTheme(Brightness.light),
      darkTheme: t.buildTheme(Brightness.dark),
      themeMode: themeMode,
      home: const HomePage(title: 'Routing'),
    );
  }
}
