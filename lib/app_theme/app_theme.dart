import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

/// General app theme.
class AppTheme {
  /// App theme for light mode and dark mode.
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: Color(0xff3550dc),
      secondary: Color(0xff27e9f7),
    ),
    primaryTextTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 18,color: Color(0xff3550dc), fontWeight: FontWeight.w500),
      headlineLarge: TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold,),
    ),
  );

  /// Returns the [ThemeData] for light mode.
  ThemeData get lightTheme => _lightTheme;
}
