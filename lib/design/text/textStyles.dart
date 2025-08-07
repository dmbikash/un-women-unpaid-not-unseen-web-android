import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

// To reduce app size, we'll create a more optimized fonts configuration
class ThemeTextStyles {
  // Use a single font family instance to reduce multiple font downloads
  static final TextStyle _baseStyle = GoogleFonts.nunitoSans();

  // Base styles for headers
  static final TextStyle _baseHeaderStyle = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: AppColors.primary,
  );

  // Base styles for regular text
  static final TextStyle _baseTextStyle = _baseStyle.copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // Heading styles
  static TextStyle heading = _baseHeaderStyle;

  static TextStyle splashScreen = _baseHeaderStyle.copyWith(
    color: AppColors.white,
    fontSize: 40,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Content styles
  static TextStyle normalTitle = _baseHeaderStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle label = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle hint = _baseTextStyle.copyWith(
    color: AppColors.textHint,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  // For key-value pairs
  static TextStyle keys = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle values = _baseTextStyle;

  // Button text
  static TextStyle button = _baseTextStyle.copyWith(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Body text
  static TextStyle body = _baseTextStyle.copyWith(
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle subtitle = _baseTextStyle.copyWith(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Small text style
  static TextStyle small = _baseTextStyle.copyWith(
    color: AppColors.textSecondary,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
}
