import 'package:fleetmanager/domain/fleetmanager_user.dart';
import 'package:fleetmanager/domain/address.dart';
import 'package:fleetmanager/domain/vehicle_types_enum.dart';
import 'package:fleetmanager/domain/user_roles_enum.dart';

class Vehicle {
  final String licensePlate;
  final FleetmanagerUser? driver; // Should have role.driver
  final VehicleType type;
  final int numberOfSeats;
  final double? maxLoad; // Optional for non-truck vehicles
  final Address garage;

  Vehicle({
    required this.licensePlate,
    required this.driver,
    required this.type,
    required this.numberOfSeats,
    this.maxLoad,
    required this.garage,
  }) {
    // Check if the user has the driver role
    assert(driver != null && driver!.role == UserRole.driver,
        'Vehicles must have a driver with role.driver.');
  }

  Map<String, dynamic> toMap() {
    return {
      'licensePlate': licensePlate,
      'fleetmanagerUser': driver?.toMap(), // Convert to map if not null
      'type': type.toString(), // Store VehicleType as a string or enum index
      'numberOfSeats': numberOfSeats,
      'maxLoad': maxLoad,
      'garage': garage.toMap(),
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      licensePlate: map['licensePlate'],
      driver: map['fleetmanagerUser'] != null
          ? FleetmanagerUser.fromMap(map['fleetmanagerUser'])
          : null,
      // Convert to FleetmanagerUser if not null
      type: VehicleType.values.firstWhere(
        (type) => type.toString() == map['type'],
        orElse: () => VehicleType.bus, // Default value, you can change this
      ),
      numberOfSeats: map['numberOfSeats'],
      maxLoad: map['maxLoad'],
      garage: Address.fromMap(map['garage']),
    );
  }

  // Static method to create a default vehicle
  static Vehicle defaultVehicle() {
    return Vehicle(
      licensePlate: '',
      driver: FleetmanagerUser.defaultUser(),
      // Create a default user
      type: VehicleType.bus,
      // Default type
      numberOfSeats: 1,
      // Default seats
      maxLoad: null,
      // Default maxLoad can be null
      garage: Address.defaultAddress(), // Create a default address
    );
  }
}
