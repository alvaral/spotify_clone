import 'package:flutter/material.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}
