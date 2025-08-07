   import 'package:flutter/material.dart';

class Gaps {
  // Vertical gaps
  static const SizedBox vTiny = SizedBox(height: 4);
  static const SizedBox vSmall = SizedBox(height: 8);
  static const SizedBox vMedium = SizedBox(height: 16);
  static const SizedBox vLarge = SizedBox(height: 24);
  static const SizedBox vXLarge = SizedBox(height: 32);
  static const SizedBox vXXLarge = SizedBox(height: 40);

  // Horizontal gaps
  static const SizedBox hTiny = SizedBox(width: 4);
  static const SizedBox hSmall = SizedBox(width: 8);
  static const SizedBox hMedium = SizedBox(width: 16);
  static const SizedBox hLarge = SizedBox(width: 24);
  static const SizedBox hXLarge = SizedBox(width: 32);

  // Padding constants
  static const EdgeInsets paddingTiny = EdgeInsets.all(4);
  static const EdgeInsets paddingSmall = EdgeInsets.all(8);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24);

  // Common button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: 32, vertical: 16);
  static const EdgeInsets smallButtonPadding = EdgeInsets.symmetric(
      horizontal: 16, vertical: 8);

  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets cardContentPadding = EdgeInsets.all(12);
}