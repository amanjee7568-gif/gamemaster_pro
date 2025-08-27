import 'package:flutter/material.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/shared/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kcPrimaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: kcBackgroundColor,
        useMaterial3: true,
      ),
      home: const StartupView(),
    );
  }
}