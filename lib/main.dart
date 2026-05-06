import 'package:app/core/app/app_theme.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latinoamérica Comparte',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/',
      theme: AppTheme.theme,
    );
  }
}