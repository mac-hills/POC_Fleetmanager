import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleetmanager/services/reservation_data_service.dart';

class FleetManagerUserService {
  final ReservationService reservationService = ReservationService();

  // Get fleet manager user data
  Future<Map<String, dynamic>> fetchFleetManagerUserData(String userId) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('fleetmanagerUsers')
        .doc(userId)
        .get();
    print('User Snapshot: $userSnapshot');
    if (!userSnapshot.exists) {
      return {};
    }
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    List<String> reservationIds =
        List<String>.from(userData['reservationIds'] ?? []);
    List<Map<String, dynamic>> reservations = [];
    for (String reservationId in reservationIds) {
      Map<String, dynamic> reservationData =
          await reservationService.fetchReservationData(reservationId);
      reservations.add(reservationData);
    }
    userData['reservations'] = reservations;
    print('User Data: $userData');
    return userData;
  }

  // Get all users with their role set to driver
  Future<List<Map<String, dynamic>>> fetchDrivers() async {
    try {
      // Query the fleetmanagerUsers collection for users with role 'driver'
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('fleetmanagerusers')
          .where('role', isEqualTo: 'driver')
          .get();
      // Process the query results and return a list of driver data
      List<Map<String, dynamic>> drivers = [];
      for (var doc in querySnapshot.docs) {
        drivers.add(doc.data() as Map<String, dynamic>);
      }
      return drivers;
    } catch (e) {
      // Handle errors
      print('Error fetching drivers: $e');
      return [];
    }
  }
}
