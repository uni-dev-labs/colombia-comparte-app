import 'package:flutter/material.dart';

abstract class AppColors {
  // Purples
  static const Color primaryPurple = Color(0xFF7C3AC7);
  static const Color primaryPurpleDark = Color(0xFF5E2A9A);
  static const Color primaryPurpleLight = Color(0xFF9B5FD4);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteTransparent = Color(0x99FFFFFF);
  static const Color formBackground = Color(0xFFF2F2F7);
  static const Color inputBorder = Color(0xFFDDDDE8);
  static const Color inputIcon = Color(0xFF9B5FD4);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B8A);
  static const Color textHint = Color(0xFFAAAAAC);
  static const Color linkColor = Color(0xFF7C3AC7);

  // Button
  static const Color buttonText = Color(0xFF5E2A9A);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryPurpleLight, primaryPurpleDark],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryPurple, Color(0xFFBF3FC7)],
  );
}
