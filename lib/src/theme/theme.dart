import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData lightThemeData = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.montserrat(
      color: AppColors.black,
      fontWeight: FontWeight.w700,
      fontSize: 32,
    ),
    titleMedium: GoogleFonts.montserrat(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: AppColors.black,
      fontWeight: FontWeight.w300,
      fontSize: 16,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: AppColors.black,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
  ),
);
