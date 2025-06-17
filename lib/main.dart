import 'package:flutter/material.dart';
import 'package:wtms/style/style.dart';
import 'package:wtms/view/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Task Management System',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Style.themeColor,
          selectionHandleColor: Style.themeColor,
          selectionColor: Colors.blue.shade100,
        ),
      ),
      home: SplashScreen()
    );
  }
}
