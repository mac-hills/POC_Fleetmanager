import 'package:flutter/foundation.dart';

class SelectedVehicleProvider extends ChangeNotifier {
  String _selectedVehicleId = '';

  String get selectedVehicleId => _selectedVehicleId;

  void setSelectedVehicleId(String vehicleId) {
    _selectedVehicleId = vehicleId;
    notifyListeners();
  }
}
