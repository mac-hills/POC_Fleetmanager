import 'package:fleetmanager/resources/app_theme.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:fleetmanager/resources/calendar_data.dart';

// Landscape mode layout: shows resource view with subject and icon
// wide resource view class that will be displayed in landscape mode
class ResourcesDetailsView extends StatelessWidget {
  final List<Appointment> appointments;
  final List<Widget> landscapeResources = const [];
  const ResourcesDetailsView({super.key, required this.appointments});
  @override
  Widget build(BuildContext context) {
    // Theme color settings
    final themeProvider = Provider.of<ThemeProvider>(context);
    final backgroundColor = themeProvider.isDarkMode
        ? AppTheme.darkTheme.scaffoldBackgroundColor
        : AppTheme.lightTheme.scaffoldBackgroundColor;
    // Get reservations
    final List<Widget> resources = getAllLandscapeResources(appointments);
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 20),
      // Set color of view to selected theme color
      color: backgroundColor,
      child: Column(
        children: resources,
      ),
    );
  }
}
