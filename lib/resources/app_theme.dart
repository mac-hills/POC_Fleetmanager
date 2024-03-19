import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    // Custom light theme
    primaryColor: Colors.blue, // Change primary color
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Custom dark theme
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[600],
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
  );
}
