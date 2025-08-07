import 'package:flutter/material.dart';

class ResponsiveTextUtils {
  static const double _kDefaultWidth = 375.0; // Base width (iPhone X)

  static double getScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width / _kDefaultWidth;
  }

  static TextStyle getStyle({
    required BuildContext context,
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    final scaleFactor = getScaleFactor(context);
    final adjustedSize = fontSize * scaleFactor;

    // Clamp the font size to prevent too small or too large text
    final clampedSize = adjustedSize.clamp(
      fontSize * 0.8, // Minimum 80% of original
      fontSize * 1.4, // Maximum 140% of original
    );

    return TextStyle(
      fontSize: clampedSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }
}