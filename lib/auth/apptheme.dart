import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark();
  static final lightThemeMode = ThemeData().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.blue.shade50,
    // colorScheme: ColorScheme.fromSwatch(
    //   primarySwatch: Colors.blue,
    //   accentColor: Colors.yellow,
    //   backgroundColor: Colors.white,
    // ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light, // For light theme
      primary: Colors.black, // Main brand color (buttons, AppBar, FAB)
      onPrimary: Colors.white, // Text/icons on primary color
      secondary: Colors.grey, // Accent color for chips, FABs, etc.
      onSecondary: Colors.black, // Text/icons on background
      surface: Color(0xFFF5F5F5), // Cards, dialogs, bottom sheets
      onSurface: Colors.black, // Text/icons on surface
      error: Colors.red, // Error color (forms, alerts)
      onError: Colors.white, // Text/icons on error color
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(),
      // color: Colors.white,
    ),
    textTheme: TextTheme(
      // DISPLAY — very large text (splash, hero sections)
      displayLarge: TextStyle(
        fontSize: 57,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      // HEADLINE — page headers
      headlineLarge: TextStyle(
        fontSize: 32,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // TITLE — section titles, app bar title
      titleLarge: TextStyle(
        fontSize: 22,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      // BODY — normal readable content
      bodyLarge: TextStyle(
        fontSize: 16,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      // LABEL — buttons, chips, captions
      labelLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
  );
}
