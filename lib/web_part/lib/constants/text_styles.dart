import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static double _stepFont(BuildContext context, double base) {
    final w = MediaQuery
        .of(context)
        .size
        .width;
    if (w <= 700) return base - 2;
    if (w > 2000) return base + 4;
    if (w > 1000) return base + 2;
    return base;
  }

  static TextStyle small(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
          fontSize: _stepFont(context, 8),
          color: color ?? AppColors.textPrimary);

  static TextStyle normal(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
          fontSize: _stepFont(context, 10),
          color: color ?? AppColors.textPrimary);

  static TextStyle medium(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 11),
        color: color ?? AppColors.primary,
        letterSpacing: 0.1,
      );

  static TextStyle h1(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 16),
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.primary,
        letterSpacing: 1.0,
      );

  static TextStyle h2(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 13),
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.primary,
        letterSpacing: 0.8,
      );

  static TextStyle h3(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 11),
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.primary,
        letterSpacing: 0.7,
      );

  static TextStyle buttonText(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 11),
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textLight,
        letterSpacing: 1.1,
        height: 1.2,
      ).copyWith(
        // Make all button labels uppercase by default!
        // Usage: Text(AppTextStyles.buttonText(context).apply(...)) or wrap in .toUpperCase() per button call if needed
      );

  static TextStyle cardTitle(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 11),
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.primary,
        letterSpacing: 0.6,
      );

  static TextStyle lightText(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 10),
        color: color ?? AppColors.textLight,
        letterSpacing: 0.3,
      );

  static TextStyle lightTextBold(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 10),
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.textLight,
        letterSpacing: 0.3,
      );

  static TextStyle largeNumber(BuildContext context, {Color? color}) =>
      GoogleFonts.poppins(
        fontSize: _stepFont(context, 20),
        fontWeight: FontWeight.w900,
        color: color ?? AppColors.textLight,
        // Shadow effect for legibility on light backgrounds
        shadows: [
          Shadow(
            blurRadius: 3,
            color: Colors.black12,
            offset: Offset(0, 1),
          )
        ],
        letterSpacing: 1.2,
      );

  static TextStyle fromStyle(BuildContext context, TextStyle base,
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return base.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}