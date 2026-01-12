import 'package:flutter/material.dart';
import 'package:safer_app/core/themes/app_text.dart';

class AppTheme {
  final lghitTheme = ThemeData(
    // Core colors
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF5B46E6),
      onPrimary: Colors.white,
      secondary: Colors.grey,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    // App bar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black87),
    ),

    scaffoldBackgroundColor: const Color(0xFFF6F5FC),

    textTheme: TextTheme(
      displayLarge: AppText.h1 as TextStyle?,
      displayMedium: AppText.h2 as TextStyle?,
      bodyLarge: AppText.body as TextStyle?,
      bodySmall: AppText.caption as TextStyle?,
      labelLarge: AppText.button as TextStyle?,
    ),

    iconTheme: const IconThemeData(color: Colors.black54),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5B46E6),
        textStyle: AppText.button as TextStyle?,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF5B46E6),
        textStyle: AppText.link as TextStyle?,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF5B46E6),
        side: const BorderSide(color: Color(0xFF5B46E6)),
        textStyle: AppText.link as TextStyle?,
      ),
    ),

    // Cards and surfaces
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF5B46E6),
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      elevation: 8,
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: const Color(0xFF5B46E6)),
      ),
      labelStyle: AppText.body as TextStyle?,
      hintStyle: AppText.caption as TextStyle?,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xFF5B46E6),
      selectionColor: const Color(0xFF5B46E6).withAlpha((0.15 * 255).round()),
      selectionHandleColor: const Color(0xFF5B46E6),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle:
          (AppText.body as TextStyle?)?.copyWith(color: Colors.white) ??
              const TextStyle(color: Colors.white),
      actionTextColor: const Color(0xFF5B46E6),
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final darkTheme = ThemeData();
}
