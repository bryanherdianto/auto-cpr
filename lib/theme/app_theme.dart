import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF111111);
  static const Color surfaceCard = Color(0x333BA9DA); // Cyan 20%
  static const Color surfacePurple = Color(0x33BB00FF); // Purple 20%
  static const Color surfaceRed = Color(0x33FF0000); // Red 20%
  
  static const Color cyan = Color(0xFF3BA9DA);
  static const Color purple = Color(0xFFBB00FF);
  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF00FF66);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF869397);
  static const Color darkGray = Color(0xFF1E1E1E);
}

class AppTypography {
  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.white,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.ibmPlexSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle mono({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.white,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
