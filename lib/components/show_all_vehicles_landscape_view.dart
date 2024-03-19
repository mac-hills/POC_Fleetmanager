import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowAllVehiclesLandscapeView extends StatelessWidget {
  final void Function(String vehicleId) onVehicleSelected;

  const ShowAllVehiclesLandscapeView(
      {super.key, required this.onVehicleSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VehicleList(
        onVehicleSelected: onVehicleSelected,
      ),
    );
  }
}

class VehicleList extends StatelessWidget {
  final void Function(String vehicleId) onVehicleSelected;

  const VehicleList({super.key, required this.onVehicleSelected});

  @override
  Widget build(BuildContext context) {
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
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                ),
              ),
              child: ListTile(
                tileColor: Colors.white,
                // Background color
                contentPadding: const EdgeInsets.all(16.0),
                // Adjust spacing
                leading: icon,
                title: Text(
                  'Type: $vehicleType',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // Add bold text style
                    fontSize: 18.0, // Adjust text size
                  ),
                ),
                subtitle: Text(
                  'License Plate: $licensePlate',
                  style: const TextStyle(
                    fontSize: 16.0, // Adjust text size
                  ),
                ),
                onTap: () {
                  onVehicleSelected(vehicleId);
                },
              ),
            );
          },
        );
      },
    );
  }
}
