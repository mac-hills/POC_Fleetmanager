import 'package:fleetmanager/domain/address.dart';
import 'package:fleetmanager/domain/fleetmanager_user.dart';
import 'package:fleetmanager/domain/vehicle.dart';

class Reservation {
  final DateTime startTime;
  final DateTime endTime;
  final Vehicle vehicle;
  final FleetmanagerUser fleetmanagerUser;
  final Address startLocation;
  final Address endLocation;

  Reservation({
    required this.startTime,
    required this.endTime,
    required this.vehicle,
    required this.fleetmanagerUser,
    required this.startLocation,
    required this.endLocation,
  });

  // Serialize the Reservation object to a map
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'vehicle': vehicle.toMap(),
      // Assuming Vehicle has a toMap method
      'fleetmanagerUser': fleetmanagerUser.toMap(),
      // Assuming User has a toMap method
      'startLocation': startLocation.toMap(),
      // Assuming Address has a toMap method
      'endLocation': endLocation.toMap(),
      // Assuming Address has a toMap method
    };
  }

// Deserialize a map to create a Reservation object
  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      vehicle: Vehicle.fromMap(map['vehicle']),
      // Assuming Vehicle has a fromMap method
      fleetmanagerUser: FleetmanagerUser.fromMap(map['fleetmanagerUser']),
      // Assuming User has a fromMap method
      startLocation: Address.fromMap(map['startLocation']),
      // Assuming Address has a fromMap method
      endLocation: Address.fromMap(
          map['endLocation']), // Assuming Address has a fromMap method
    );
  }
}
