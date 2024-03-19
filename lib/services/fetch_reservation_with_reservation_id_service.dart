import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchReservation(String reservationId) async {
  // Reference to the reservation document
  DocumentReference reservationRef =
      FirebaseFirestore.instance.collection('reservation').doc(reservationId);
  // Get the reservation data
  DocumentSnapshot reservationSnapshot = await reservationRef.get();
  if (reservationSnapshot.exists) {
    // Reservation data found
    Map<String, dynamic> reservationData =
        reservationSnapshot.data() as Map<String, dynamic>;
    // Retrieve startTime and endTime
    Timestamp startTimeTimestamp = reservationData['startTime'] as Timestamp;
    Timestamp endTimeTimestamp = reservationData['endTime'] as Timestamp;
    // Convert Timestamps to DateTime objects
    DateTime startTime = startTimeTimestamp.toDate();
    DateTime endTime = endTimeTimestamp.toDate();
    // Retrieve endLocation data
    DocumentReference endLocationRef =
        reservationData['endLocation'] as DocumentReference;
    DocumentSnapshot endLocationSnapshot = await endLocationRef.get();
    Map<String, dynamic> endLocationData =
        endLocationSnapshot.data() as Map<String, dynamic>;
    // Retrieve startLocation data
    DocumentReference startLocationRef =
        reservationData['startLocation'] as DocumentReference;
    DocumentSnapshot startLocationSnapshot = await startLocationRef.get();
    Map<String, dynamic> startLocationData =
        startLocationSnapshot.data() as Map<String, dynamic>;
    // Retrieve organizer data
    DocumentReference organizerRef =
        reservationData['organizer'] as DocumentReference;
    DocumentSnapshot organizerSnapshot = await organizerRef.get();
    Map<String, dynamic> organizerData =
        organizerSnapshot.data() as Map<String, dynamic>;
    // Retrieve vehicle data
    DocumentReference vehicleRef =
        reservationData['vehicle'] as DocumentReference;
    DocumentSnapshot vehicleSnapshot = await vehicleRef.get();
    Map<String, dynamic> vehicleData =
        vehicleSnapshot.data() as Map<String, dynamic>;
    // Retrieve repetition data
    String repetition = reservationData['repeat'];
    // Return all the retrieved data as a Map
    return {
      'startTime': startTime,
      'endTime': endTime,
      'reservationData': reservationData,
      'endLocationData': endLocationData,
      'startLocationData': startLocationData,
      'organizerData': organizerData,
      'vehicleData': vehicleData,
      'repeat': repetition,
    };
  } else {
    // Reservation data not found
    return {}; // or throw an exception if needed
  }
}
