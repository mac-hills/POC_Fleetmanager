import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/components/vehicle_upload_view.dart';
import 'package:fleetmanager/pages/show_all_vehicles_and_details_page.dart';
import 'package:fleetmanager/components/reservation_details_view.dart';
import 'package:fleetmanager/pages/about_page.dart';
import 'package:fleetmanager/pages/settings_page.dart';
import 'package:fleetmanager/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fleetmanager/pages/logout_page.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:provider/provider.dart';

// The appBar will not be visible in every view -> isVisible setting
// The appBar also holds the apps menu
// The menu will not be visible in every view or on every page -> showMenu setting
// The menu will be different depending on the role of the user that logs in -> isAdmin setting
// The color of the appBar depends on the setting the user chose -> ThemeProvider
AppBar buildAppBar(BuildContext context, String appBarName,
    {bool showMenu = true, bool isVisible = true}) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  const appBarTitleStyle = TextStyle(
    color: Colors.white,
  );
  final backgroundColor = themeProvider.isDarkMode
      ? AppTheme.darkTheme.primaryColor
      : AppTheme.lightTheme.primaryColor;

  // Define initial values for title and isAdmin
  bool isAdmin = false;

  // Fetch user data
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userId = user.uid;
    FirebaseFirestore.instance
        .collection('fleetmanagerusers')
        .doc(userId)
        .get()
        .then((userData) {
      if (userData.exists) {
        final userName = userData.get('name');
        final userRole = userData.get('role');
        appBarName = userName;
        if (userRole == 'admin') {
          isAdmin = true;
        }
      }
    });
  }

  if (!showMenu) {
    // If showMenu is false, return an AppBar without the menu icon
    return AppBar(
      title: Text(appBarName, style: appBarTitleStyle),
      backgroundColor: backgroundColor,
    );
  }
  if (!isVisible) {
    // If isVisible is false, return an empty container
    return AppBar(
      automaticallyImplyLeading: false,
    );
  }

  // If showMenu is true, return an AppBar with the menu icon
  return AppBar(
    title: Text(appBarName, style: appBarTitleStyle),
    backgroundColor: backgroundColor,
    actions: [
      PopupMenuButton<String>(
        icon: const Icon(Icons.menu),
        onSelected: (value) {
          handleMenuItemSelection(context, value);
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'Show vehicles',
              child: Text('Show vehicles'),
            ),
            if (isAdmin)
              const PopupMenuItem<String>(
                value: 'Add vehicle',
                child: Text('Add vehicle'),
              ),
            const PopupMenuItem<String>(
              value: 'settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'about',
              child: Text('About'),
            ),
            const PopupMenuItem<String>(
              value: 'log_out',
              child: Text('Log Out'),
            ),

            if (isAdmin)
              const PopupMenuItem<String>(
                value: 'Reservations',
                child: Text('Reservations'),
              ),
          ];
        },
      ),
    ],
  );
}

void handleMenuItemSelection(BuildContext context, String? value) {
  if (value == null) return;

  switch (value) {
    case 'Show vehicles': // Navigate to the logout page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ShowAllVehiclesAndDetailsPage()));
      break;
    case 'settings': // Navigate to the settings page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
      break;
    case 'about': // Navigate to the about page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AboutPage()));
      break;
    case 'log_out': // Navigate to the logout page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LogOutPage()));
      break;

    case 'Reservations': // Navigate to the logout page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SingleReservationDetailsView()));
      break;
    case 'Add vehicle': // Navigate to the reservations page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddVehicle()));
      break;
  }
}
