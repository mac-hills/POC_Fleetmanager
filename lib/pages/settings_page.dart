import 'package:fleetmanager/resources/app_theme.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Define styles based on the theme mode
    const appBarTitleStyle = TextStyle(
      color: Colors.white,
    );
    final backgroundColor = themeProvider.isDarkMode
        ? AppTheme.darkTheme.primaryColor
        : AppTheme.lightTheme.primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: appBarTitleStyle,
        ),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        color: backgroundColor,
        child: ListTile(
          title: const Text(
            'Dark Mode',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ),
      ),
    );
  }
}
