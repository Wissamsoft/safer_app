import 'package:flutter/material.dart';
import 'package:safer_app/core/themes/app_text.dart';

class AppTheme {
  final lghitTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,

      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),

    ),

    iconTheme: IconThemeData(
      color: Colors.black,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),

    scaffoldBackgroundColor: Colors.white,

    textTheme: TextTheme(
      displayLarge: AppText.h1 as TextStyle?,
      displayMedium: AppText.h2 as TextStyle?,
      bodyLarge: AppText.body as TextStyle?,
      bodySmall: AppText.caption as TextStyle?,
      labelLarge: AppText.button as TextStyle?,
    ),

    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.grey,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),

    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue, 
        textStyle: AppText.link as TextStyle?,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue,
        textStyle: AppText.button as TextStyle?,
      ),
    ),  

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue, 
        side: BorderSide(color: Colors.blue),
        textStyle: AppText.link as TextStyle?,
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue.withOpacity(0.5),
      selectionHandleColor: Colors.blue,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue),
      ),
      labelStyle: AppText.body as TextStyle?,
      hintStyle: AppText.caption as TextStyle?,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: (AppText.body as TextStyle?)?.copyWith(color: Colors.white) ?? TextStyle(color: Colors.white),
      actionTextColor: Colors.blue,
    ),
  );

  final darkTheme = ThemeData(
    
  );
}
