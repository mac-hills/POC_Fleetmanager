import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/domain/user_roles_enum.dart';
import 'package:fleetmanager/domain/reservation.dart';

class FleetmanagerUser {
  final String uid; // Linked to Firebase Authentication uid
  final String email; // Linked to Firebase Authentication email
  final UserRole role;
  final List<Reservation> reservations;

  FleetmanagerUser({
    required this.uid,
    required this.email,
    required this.role,
    List<Reservation>? reservations,
  }) : reservations = reservations ?? [];

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> reservationsList =
        reservations.map((reservation) => reservation.toMap()).toList();
    return {
      'uid': uid,
      'email': email,
      'role': role.toString(), // Store UserRole as a string or enum index
      'reservations': reservationsList,
    };
  }

  factory FleetmanagerUser.fromMap(Map<String, dynamic> map) {
    // Deserialize reservations from the map
    List<Map<String, dynamic>> reservationsList =
        (map['reservations'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    List<Reservation> reservations = reservationsList
        .map((reservationMap) => Reservation.fromMap(reservationMap))
        .toList();

    return FleetmanagerUser(
      uid: map['uid'],
      email: map['email'],
      role: UserRole.values.firstWhere(
        (role) => role.toString() == map['role'],
        orElse: () => UserRole.guest,
      ),
      reservations: reservations,
    );
  }

  factory FleetmanagerUser.fromFirebaseUser(User firebaseUser, UserRole role) {
    return FleetmanagerUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      role: role,
    );
  }

  // Static method to create a default user
  static FleetmanagerUser defaultUser() {
    return FleetmanagerUser(
      uid: '',
      email: '',
      role: UserRole.guest, // You can set a different default role if needed
    );
  }
}
