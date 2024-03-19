import 'package:flutter/material.dart';

class VehicleIconService {
  static Icon getVehicleIcon(
      String vehicleType, Color iconColor, double iconSize) {
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
        iconData = Icons.directions_car; // Default icon
        break;
    }
    return Icon(
      iconData,
      size: iconSize,
      color: iconColor, // Icon color
      shadows: const [
        Shadow(
          color: Colors.black,
          offset: Offset(2, 2),
          blurRadius: 2,
        ),
      ],
    );
  }
}
