import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0099D8);
  static const Color primaryLight = Color(0xFF33B4E6);
  static const Color primaryDark = Color(0xFF0077A8);

  // Accent colors
  static const Color accent = Color(0xFFFFD700);

  static final Color background = HexColor('FFFFFF');
  // Neutral colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color gray = Color(0xFF707070);
  static const Color lightGray = Color(0xFFF0F2F5);
  static const Color mediumGray = Color(0xFFAAAAAA);
  static const Color darkGray = Color(0xFF555555);

  // Alert colors
  static const Color error = Color(0xFFAA4A44);
  static const Color errorLight = Color(0xFFFADADA);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Card colors
  static const Color cardBorder = primary;
  static const Color cardBackground = white;

  // Button colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = Color(0xFF707070);
  static const Color buttonDisabled = Color(0xFFCCCCCC);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = white;
  static const Color textDisabled = Color(0xFFAAAAAA);
}

// Utility class for hex color conversion
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
