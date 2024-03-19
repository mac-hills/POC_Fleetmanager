import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/components/calendar_driver_view.dart';
import 'package:fleetmanager/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:fleetmanager/components/app_bar_view.dart';
import 'package:fleetmanager/resources/calendar_data.dart';
import 'package:fleetmanager/components/resources_icons_view.dart';
import 'package:fleetmanager/components/resources_details_view.dart';

// this class combines the different views based on the orietation of the screen
class HomePageDrivers extends StatelessWidget {
  const HomePageDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = Auth().currentUser;

  List<Appointment> appointments = [];
  String name = '';
  String userRole = '';

  // Method to fetch user's data from Firestore
  Future<void> fetchUserData() async {
    final userId = user?.uid; // Assuming uid is the Firestore document ID
    if (userId != null) {
      final userData = await FirebaseFirestore.instance
          .collection('fleetmanagerusers')
          .doc(userId)
          .get();

      if (userData.exists) {
        final userName = userData.get('name');
        final role = userData.get('role');
        setState(() {
          name = userName ?? 'User email';
          userRole = role ?? '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    appointments = getAllAppointments();
    fetchUserData();
  }

  // Component builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar -> Title + Menu icon + Logout icon
      appBar: buildAppBar(context, 'Welcome $name.\nThis is your schedule:'),

      // Body: Calendar component
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the aspect ratio of the screen
          if (constraints.maxWidth > constraints.maxHeight) {
            // Landscape mode layout
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResourcesDetailsView(appointments: appointments),
                Expanded(
                  // Expanded widget to fill the remaining space
                  child: CalendarDriverView(appointments: appointments),
                ),
              ],
            );
          } else {
            // Portrait mode layout
            return Row(
              children: [
                ResourcesIconsView(appointments: appointments),
                Expanded(
                  // Expanded widget to fill the remaining space
                  child: CalendarDriverView(appointments: appointments),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
