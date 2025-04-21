import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary50 = Color(0xFFFEF9F6);
  static const Color primary100 = Color(0xFFFDF0E9);
  static const Color primary200 = Color(0xFFF9DAC7);
  static const Color primary300 = Color(0xFFF4B68F);
  static const Color primary400 = Color(0xFFEE9157);
  static const Color primary500 = Color(0xFFE96D1F); //E96D1F
  static const Color primary600 = Color(0xFF743610);
  static const Color primary700 = Color(0xFF3A1B08);

  // Green colors
  static const Color green50 = Color(0xFFF0F8F2);
  static const Color green100 = Color(0xFFE0F2E5);
  static const Color green200 = Color(0xFFC2E5CB);
  static const Color green300 = Color(0xFF85CB98);
  static const Color green400 = Color(0xFF5DB975);
  static const Color green500 = Color(0xFF34A853);
  static const Color green600 = Color(0xFF277E3E);
  static const Color green700 = Color(0xFF1A5429);

  // Red colors
  static const Color red50 = Color(0xFFFFEFF1);
  static const Color red100 = Color(0xFFFFDFE3);
  static const Color red200 = Color(0xFFFFC0C8);
  static const Color red300 = Color(0xFFFD93A0);
  static const Color red400 = Color(0xFFFF7485);
  static const Color red500 = Color(0xFFF0475C);
  static const Color red600 = Color(0xFFEF233C);
  static const Color red700 = Color(0xFFB31A2D);

  // Yellow colors
  static const Color yellow50 = Color(0xFFFFFBF3);
  static const Color yellow100 = Color(0xFFFFF7E8);
  static const Color yellow200 = Color(0xFFFFF0D1);
  static const Color yellow300 = Color(0xFFFFE2A4);
  static const Color yellow400 = Color(0xFFFFD376);
  static const Color yellow500 = Color(0xFFFFC549);
  static const Color yellow600 = Color(0xFFFFB61B);
  static const Color yellow700 = Color(0xFFBF8814);

  // Grey colors
  static const Color grey50 = Color(0xFFF7F8F9);
  static const Color grey100 = Color(0xFFF3F5F6);
  static const Color grey200 = Color(0xFFDEE2E6);
  static const Color grey300 = Color(0xFFCED4DA);
  static const Color grey400 = Color(0xFFADB5BD);
  static const Color grey500 = Color(0xFF6C757D);
  static const Color grey600 = Color(0xFF2F2F2F);
  static const Color grey700 = Color(0xFF232323);

  // Secondary colors
  static const Color background = Color(0xFF3F3B50);
  static const Color foreground = Color(0xFF22202C);

  // Card Gradient Colors
  static const cardGradientStart = Color(0xFFF7FAF1);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF0F0F0F);
  static const blue = Color(0xFF254AA5); //#254AA5

  static const cardGradientEnd = Color(0xFFFCF5F5);
  static const transparent = Color(0x00000000); 
  static const cardColor = Color(0xFF3f3a51);
  

  //Brown
  static const brown = Color(0xFFa3967c);
  static const brownPrimary = Color(0xFF795548);


  


  //Linear Gradient
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
    colors: [
      cardGradientStart, //F7FAF1
      white, //FFFFFF
      cardGradientEnd, // FCF5F5
    ],
  );

  // Helper method to apply card gradient to a container
  static BoxDecoration cardGradientDecoration({
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) {
    return BoxDecoration(
      gradient: cardGradient,
      borderRadius: borderRadius,
    );
  }
}
