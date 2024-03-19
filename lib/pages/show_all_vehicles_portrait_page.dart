import 'package:fleetmanager/components/vehiclelist.dart';
import 'package:flutter/material.dart';
class ShowAllVehiclesPortraitPage extends StatelessWidget {
  const ShowAllVehiclesPortraitPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Vehicles'),
      ),
      body: const VehicleList(),
    );
  }
}


