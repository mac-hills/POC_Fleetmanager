import 'package:fleetmanager/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadThemeSettings(); // Load theme settings from SharedPreferences during initialization
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _themeData = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

    // Save the theme setting to SharedPreferences
    _saveThemeSettings();

    notifyListeners();
  }

  // Load theme settings from SharedPreferences
  Future<void> _loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    toggleTheme(isDarkMode);
  }

  // Save theme settings to SharedPreferences
  // The theme settings are stored on the device of the user
  Future<void> _saveThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
