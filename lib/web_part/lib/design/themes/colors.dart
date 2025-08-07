import 'package:flutter/material.dart';

class AppColors {
  // Primary color - 008DCB
  //static final Color primary = HexColor('E8ECF3');
  static final Color primary = HexColor('008DCB');
  static final Color primaryLight = HexColor('008DCB').withOpacity(0.8);
  static final Color primaryDark = HexColor('0078AF');

  // Background color - E8ECF3
 // static final Color background = HexColor('E8ECF3');
  static final Color background = HexColor('FFFFFF');

  // Container/card color - F8F9FA
  static final Color container = HexColor('F8F9FA');

  // Basic colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static final Color black54 = Colors.black54;
  static final Color grey = Colors.grey;
  static final Color error = Colors.red;
  static final Color success = Colors.green;

  // Gradients
  static final LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text colors
  static final Color textPrimary = black;
  static final Color textSecondary = black.withOpacity(0.6);
  static final Color textHint = grey;
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
