import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleDataService {
  // Get vehicle data of
  Future<Map<String, dynamic>> fetchVehicleData(String vehicleId) async {
    DocumentSnapshot vehicleSnapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleId)
        .get();
    if (!vehicleSnapshot.exists) {
      return {};
    }
    Map<String, dynamic> vehicleData =
        vehicleSnapshot.data() as Map<String, dynamic>;
    // Get driver data
    DocumentReference driverRef = vehicleData['driver'] as DocumentReference;
    DocumentSnapshot driverSnapshot = await driverRef.get();
    Map<String, dynamic> driverData =
        driverSnapshot.data() as Map<String, dynamic>;
    // Get garage data
    DocumentReference garageRef = vehicleData['garage'] as DocumentReference;
    DocumentSnapshot garageSnapshot = await garageRef.get();
    Map<String, dynamic> garageData =
        garageSnapshot.data() as Map<String, dynamic>;
    print("Fetching data for vehicleId: $vehicleId");
    return {
      'vehicleData': vehicleData,
      'driverData': driverData,
      'garageData': garageData,
    };
  }

  // Upload a vehicle to the firestore collection vehicles
  Future<void> addVehicle(Map<String, dynamic> vehicleData) async {
    try {
      // Add the vehicle data to the "vehicles" collection
      await FirebaseFirestore.instance.collection('vehicles').add(vehicleData);
    } catch (e) {
      // Handle errors
      print('Error adding vehicle: $e');
    }
  }
}
