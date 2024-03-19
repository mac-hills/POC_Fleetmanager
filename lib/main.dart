import 'package:fleetmanager/services/selected_vehicle_provider_service.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:fleetmanager/services/widget_tree_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleetmanager/services/firestore_read_write_tracker_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Initialize performance tracker
  FirestoreReadWriteTracker.start();
  // Initialize theme
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  // Initialize providers (theme and selections)
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SelectedVehicleProvider()),
        // Add other providers when they're ready
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData, // Apply the selected theme
      home: const WidgetTree(),
    );
  }
}
