import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 99, 171, 94);
  static const Color secondary = Color.fromARGB(255, 181, 230, 189);
  static const Color background = Color(0xFFF5F7F6);
  static const Color accent = Color(0xFFDDBEA9);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    /// Fonts
    fontFamily: 'NotoSansThai',
    scaffoldBackgroundColor: background,
    /// ColorScheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,

      /// Word
      onSurface: Color(0xFF1F2933),
    ),
    /// TextTheme = size + weight
    textTheme: const TextTheme(
       titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    /// AppBar ใช้สีจาก ColorScheme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
