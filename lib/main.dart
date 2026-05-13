import 'package:app/core/app/app_theme.dart';
import 'package:app/core/services/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latinoamérica Comparte',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: routes,
      theme: AppTheme.theme,
    );
  }
}