import 'package:flutter/material.dart';

enum VehicleType { bus, truck, taxi, van }

Map<VehicleType, IconData> vehicleTypeIcons = {
  VehicleType.bus: Icons.directions_bus_filled,
  VehicleType.truck: Icons.local_shipping,
  VehicleType.taxi: Icons.local_taxi,
  VehicleType.van: Icons.airport_shuttle,
};

IconData getIconForVehicleType(VehicleType vehicleType) {
  return vehicleTypeIcons[vehicleType] ?? Icons.directions_bus_filled;
}
