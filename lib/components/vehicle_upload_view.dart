import 'package:fleetmanager/pages/show_all_vehicles_and_details_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleetmanager/services/domain_vehicle_service.dart';
import 'package:fleetmanager/services/fleetmanageruser_data_service.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final VehicleService vehicleService = VehicleService();
  final FleetManagerUserService fleetManagerUserService =
      FleetManagerUserService();
  String licensePlate = '';
  String vehicleType = '';
  int numberOfSeats = 0;
  double maxLoad = 0.0;
  String selectedDriverId = '';
  String selectedGarageId = '';
  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController maxLoadController = TextEditingController();

  @override
  void dispose() {
    licensePlateController.dispose();
    vehicleTypeController.dispose();
    numberOfSeatsController.dispose();
    maxLoadController.dispose();
    super.dispose();
  }

  bool validateInput() {
    if (licensePlate.isEmpty ||
        !RegExp(r'^[A-Za-z0-9\-\s]*$').hasMatch(licensePlate) ||
        vehicleType.isEmpty ||
        selectedDriverId.isEmpty ||
        selectedGarageId.isEmpty) {
      // Display a message indicating that all fields must be filled in
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please fill in all fields and ensure valid input.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false; // Validation failed
    }
    if (numberOfSeats < 1 || numberOfSeats > 99) {
      // Display an error message for the number of seats
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Number of seats must be a number between 1 and 99.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false; // Validation failed
    }

    if (maxLoad <= 0.0) {
      // Display an error message for max load
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Max load must be a positive number.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false; // Validation failed
    }
    return true; // Validation succeeded
  }

  Future<void> uploadVehicleData() async {
    if (validateInput()) {
      try {
        final Map<String, dynamic> vehicleData = {
          'licensePlate': licensePlate,
          'type': vehicleType,
          'numberOfSeats': numberOfSeats,
          'maxLoad': maxLoad,
          'driver': FirebaseFirestore.instance
              .collection('fleetmanagerusers')
              .doc(selectedDriverId),
          'garage': FirebaseFirestore.instance
              .collection('address')
              .doc(selectedGarageId),
        };
        await FirebaseFirestore.instance
            .collection('vehicles')
            .add(vehicleData);
        // Navigate to another page or show a success message
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ShowAllVehiclesAndDetailsPage(),
          ),
        );
      } catch (e) {
        print('Error uploading vehicle data: $e');
      }
    }
  }

  void updateLicensePlate(String value) {
    setState(() {
      licensePlate = value;
    });
  }

  void updateVehicleType(String value) {
    setState(() {
      vehicleType = value;
    });
  }

  void updateNumberOfSeats(String value) {
    setState(() {
      numberOfSeats = int.tryParse(value) ?? 0;
    });
  }

  void updateMaxLoad(String value) {
    setState(() {
      maxLoad = double.tryParse(value) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a vehicle to the fleet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFormField(
                label: 'License Plate',
                controller: licensePlateController,
                onChanged: updateLicensePlate,
              ),
              _buildVehicleTypeDropdown(),
              _buildTextFormField(
                label: 'Number of Seats',
                controller: numberOfSeatsController,
                onChanged: updateNumberOfSeats,
              ),
              _buildTextFormField(
                label: 'Maximum Load Capacity (in kg)',
                controller: maxLoadController,
                onChanged: updateMaxLoad,
              ),
              _buildDriverDropdown(),
              _buildGarageDropdown(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: uploadVehicleData,
                  child: const Text(
                    'Add vehicle',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  Widget _buildVehicleTypeDropdown() {
    final vehicleTypes = ['bus', 'taxi', 'truck', 'van'];

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Select Vehicle Type'),
      value: vehicleType.isEmpty ? null : vehicleType,
      items: vehicleTypes.map<DropdownMenuItem<String>>((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          vehicleType = value!;
        });
      },
    );
  }

  Widget _buildDriverDropdown() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fleetManagerUserService.fetchDrivers(),
      builder: (context, snapshot) {
        print("Snapshot: $snapshot");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No drivers found.');
        }

        final drivers = snapshot.data!;

        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Select Driver'),
          value: selectedDriverId.isEmpty ? null : selectedDriverId,
          items: drivers.map<DropdownMenuItem<String>>((driver) {
            final driverName = driver['name'];
            final driverId = driver['uid'];
            return DropdownMenuItem<String>(
              value: driverId,
              child: Text(driverName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedDriverId = value!;
            });
          },
        );
      },
    );
  }

  Widget _buildGarageDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('address')
          .where('role', isEqualTo: 'garage')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final garages = snapshot.data!.docs;
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Select Garage'),
          value: selectedGarageId.isEmpty ? null : selectedGarageId,
          items: garages.map<DropdownMenuItem<String>>((garage) {
            final garageName = garage['name'];
            final garageId = garage.id;
            return DropdownMenuItem<String>(
              value: garageId,
              child: Text(garageName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGarageId = value!;
            });
          },
        );
      },
    );
  }
}
