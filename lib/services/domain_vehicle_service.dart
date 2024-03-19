import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleetmanager/domain/vehicle.dart';

class VehicleService {
// Create a reference to the Firestore collection
  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('vehicles');

// Create a new vehicle
  Future<void> addVehicle(Vehicle vehicle) async {
    await vehiclesCollection.add(vehicle.toMap());
  }

// Get all vehicles
  Future<List<Vehicle>> getAllVehicles() async {
    QuerySnapshot querySnapshot = await vehiclesCollection.get();
    return querySnapshot.docs.where((doc) {
      final data = doc.data();
      return data != null;
    }).map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Cast data to Map
      return Vehicle.fromMap(data);
    }).toList();
  }

// get 1 vehicle
  Future<Vehicle?> getVehicleById(String vehicleId) async {
    DocumentSnapshot docSnapshot =
        await vehiclesCollection.doc(vehicleId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return Vehicle.fromMap(data);
    } else {
      return null;
    }
  }

// Update a vehicle
  Future<void> updateVehicle(String vehicleId, Vehicle updatedVehicle) async {
    await vehiclesCollection.doc(vehicleId).update(updatedVehicle.toMap());
  }

// Delete a Vehicle
  Future<void> deleteVehicle(String vehicleId) async {
    await vehiclesCollection.doc(vehicleId).delete();
  }
}
