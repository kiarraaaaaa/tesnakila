import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color secondaryBlue = Color(0xFF60A5FA);
  static const Color darkBlue = Color(0xFF1E3A8A);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [
      Color(0xFF2563EB),
      Color(0xFF60A5FA),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}