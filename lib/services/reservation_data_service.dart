import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  Future<Map<String, dynamic>> fetchReservationData(
      String reservationId) async {
    // Get reservation data
    DocumentSnapshot reservationSnapshot = await FirebaseFirestore.instance
        .collection('reservation')
        .doc(reservationId)
        .get();
    if (!reservationSnapshot.exists) {
      return {};
    }
    Map<String, dynamic> reservationData =
        reservationSnapshot.data() as Map<String, dynamic>;
    // Fetch start location data
    DocumentReference startLocationRef =
        reservationData['startLocation'] as DocumentReference;
    DocumentSnapshot startLocationSnapshot = await startLocationRef.get();
    Map<String, dynamic> startLocationData =
        startLocationSnapshot.data() as Map<String, dynamic>;
    // Fetch end location data
    DocumentReference endLocationRef =
        reservationData['endLocation'] as DocumentReference;
    DocumentSnapshot endLocationSnapshot = await endLocationRef.get();
    Map<String, dynamic> endLocationData =
        endLocationSnapshot.data() as Map<String, dynamic>;
    // Fetch fleet manager user data
    DocumentReference fleetManagerUserRef =
        reservationData['fleetmanagerUser'] as DocumentReference;
    DocumentSnapshot fleetManagerUserSnapshot = await fleetManagerUserRef.get();
    Map<String, dynamic> fleetManagerUserData =
        fleetManagerUserSnapshot.data() as Map<String, dynamic>;
    // Fetch vehicle data
    DocumentReference vehicleRef =
        reservationData['vehicle'] as DocumentReference;
    DocumentSnapshot vehicleSnapshot = await vehicleRef.get();
    Map<String, dynamic> vehicleData =
        vehicleSnapshot.data() as Map<String, dynamic>;
    return {
      'reservationData': reservationData,
      'startLocationData': startLocationData,
      'endLocationData': endLocationData,
      'fleetManagerUserData': fleetManagerUserData,
      'vehicleData': vehicleData,
    };
  }
}
