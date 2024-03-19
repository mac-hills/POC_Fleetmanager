import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleetmanager/pages/show_vehicle_details_page.dart';
import 'package:fleetmanager/resources/app_theme.dart';
import 'package:fleetmanager/services/selected_vehicle_provider_service.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetmanager/services/vehicle_icon_service.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    // Listeners
    // ThemeProvider is used to check the users theme preference
    // The users theme preference is used for setting the app's theme colors
    final themeProvider = Provider.of<ThemeProvider>(context);
    // SelectedVehicleProvider is used for event handling and page navigation
    final selectedVehicleProvider =
        Provider.of<SelectedVehicleProvider>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for data
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          // show loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        // ListView.builder is het equivalent van RecyclerView in Flutter.
        // It's for larger or dynamic lists where performance matters and
        // it efficiently manages the rendering of items as the user scrolls through the list.
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final vehicleData = documents[index].data() as Map<String, dynamic>;
            final vehicleId = documents[index].id; // Get the vehicleId
            final vehicleType = vehicleData['type'] as String;
            final licensePlate = vehicleData['licensePlate'] as String;
            // method for getting icons to match the vehicle types with the service for it
            Color iconColor = themeProvider.isDarkMode
                ? AppTheme.darkTheme.primaryColor
                : AppTheme.lightTheme.primaryColor;
            final icon = VehicleIconService.getVehicleIcon(
              vehicleType,
              iconColor,
              24.0,
            );

            return ListTile(
              leading: icon,
              title: Text('Type: $vehicleType'),
              subtitle: Text('License Plate: $licensePlate'),
              onTap: () {
                if (orientation == Orientation.landscape) {
                  // if orientation is landscape, set a vehicleId for use in another view
                  // that view will be displayed in landscape mode alongside the VehicleList
                  selectedVehicleProvider.setSelectedVehicleId(vehicleId);
                } else {
                  // Portrait orientation behavior
                  // Navigate to VehicleDetailView when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VehicleDetailsPage(vehicleId: vehicleId),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
