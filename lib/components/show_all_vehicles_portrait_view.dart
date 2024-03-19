import 'package:fleetmanager/pages/show_vehicle_details_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowAllVehiclesPortraitView extends StatelessWidget {
  const ShowAllVehiclesPortraitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VehicleList(),
    );
  }
}

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // show loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final vehicleData = documents[index].data() as Map<String, dynamic>;
            final vehicleId = documents[index].id; // Get the vehicleId
            final vehicleType = vehicleData['type'] as String;
            final licensePlate = vehicleData['licensePlate'] as String;
            // method for getting icons to match the vehicle types
            Icon getVehicleIcon(String vehicleType) {
              const iconSize = 24.0;
              IconData iconData;
              switch (vehicleType) {
                case 'taxi':
                  iconData = Icons.local_taxi;
                  break;
                case 'bus':
                  iconData = Icons.directions_bus_filled;
                  break;
                case 'truck':
                  iconData = Icons.local_shipping;
                  break;
                case 'van':
                  iconData = Icons.airport_shuttle;
                  break;
                default:
                  iconData =
                      Icons.directions_car; // Default icon for unknown types
                  break;
              }
              return Icon(
                iconData,
                size: iconSize,
                color: Colors.blue, // Icon color
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
              );
            }

            final icon = getVehicleIcon(vehicleType);
            return ListTile(
              leading: icon,
              title: Text('Type: $vehicleType'),
              subtitle: Text('License Plate: $licensePlate'),
              onTap: () {
                // Navigate to VehicleDetailView when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VehicleDetailsPage(vehicleId: vehicleId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
