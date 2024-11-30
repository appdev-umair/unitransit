
import 'package:flutter/material.dart';

import '../core/constants/color_constant.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primaryColor),
    primaryColor: ColorConstant.primaryColor,
    textTheme: const TextTheme().copyWith(
      displayLarge: const TextStyle().copyWith(
        fontFamily: 'HankenGrotesk',
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: const TextStyle().copyWith(
          fontFamily: 'HankenGrotesk', color: ColorConstant.blueDarkColor),
      bodyMedium: const TextStyle().copyWith(
          fontFamily: 'HankenGrotesk', color: ColorConstant.blueDarkColor),
      bodySmall: const TextStyle().copyWith(
          fontFamily: 'HankenGrotesk', color: ColorConstant.blueDarkColor),
      titleMedium: const TextStyle()
          .copyWith(fontFamily: 'HankenGrotesk', fontWeight: FontWeight.w500),
      titleLarge: const TextStyle()
          .copyWith(fontFamily: 'HankenGrotesk', fontWeight: FontWeight.w500),
      headlineLarge: const TextStyle()
          .copyWith(fontFamily: 'HankenGrotesk', fontWeight: FontWeight.bold),
      headlineSmall: const TextStyle().copyWith(fontFamily: 'HankenGrotesk'),
    ),
    dividerTheme: const DividerThemeData(color: ColorConstant.blueDarkColor, thickness: 1.2),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: ColorConstant.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstant.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
            fontFamily: 'HankenGrotesk',
            fontStyle: FontStyle.normal,
            fontSize: 15,
            fontWeight: FontWeight.w600),
        padding: const EdgeInsets.all(16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(4),
          foregroundColor: ColorConstant.primaryColor,
          textStyle: const TextStyle(
              fontFamily: 'HankenGrotesk',
              fontStyle: FontStyle.normal,
              fontSize: 15,
              fontWeight: FontWeight.bold)),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle().copyWith(
          fontFamily: 'HankenGrotesk',
          fontStyle: FontStyle.normal,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ColorConstant.blueDarkColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstant.blueDarkColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstant.blueDarkColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstant.blueDarkColor),
      ),
      labelStyle: const TextStyle(color: ColorConstant.blueDarkColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      suffixIconColor: ColorConstant.blueDarkColor
    ),
  );
}
