import 'package:fleetmanager/components/app_bar_view.dart';
import 'package:fleetmanager/components/vehiclelist.dart';
import 'package:fleetmanager/services/selected_vehicle_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:fleetmanager/components/show_vehicle_details_view.dart';
import 'package:provider/provider.dart';

class ShowAllVehiclesAndDetailsPage extends StatefulWidget {
  const ShowAllVehiclesAndDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShowAllVehiclesAndDetailsPageState();
}

class _ShowAllVehiclesAndDetailsPageState
    extends State<ShowAllVehiclesAndDetailsPage> {
  bool isLandscape = false;

  // SelectedVehicleProvider is used for event handling and page navigation
  final selectedVehicleProvider = SelectedVehicleProvider();

  @override
  Widget build(BuildContext context) {
    // Determine screen orientation
    final orientation = MediaQuery.of(context).orientation;
    isLandscape = orientation == Orientation.landscape;
    return Scaffold(
      appBar: isLandscape
          // depending on the orientation of the screen the title in the appBar will change
          ? buildAppBar(context, 'All Vehicles and details')
          : buildAppBar(context, 'All Vehicles'),
      body: isLandscape
          ? Row(
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: VehicleList(),
                ),
                Expanded(
                  flex: 2,
                  // This Consumer widget listens for changes in the selected vehicle
                  // When a vehicle is tapped in landscape mode,
                  // it updates the right portion of the screen to show the details of the selected vehicle using ShowVehicleDetailsView.
                  child: Consumer<SelectedVehicleProvider>(
                    builder: (context, provider, _) {
                      // get the vehicleId from the tapped vehicle VehicleList view
                      // this is set with the onTap method in the VehicleList's returned ListTile
                      final selectedVehicleId = provider.selectedVehicleId;
                      // As long as no vehicle is selected, show the info of the default vehicle
                      if (selectedVehicleId.isEmpty) {
                        return ShowVehicleDetailsView(
                            vehicleId: '02B8hY3DH64HoKXGu8s4');
                        // If a vehicle is selected, show the selected vehicles info
                      } else {
                        return ShowVehicleDetailsView(
                            vehicleId: selectedVehicleId);
                      }
                    },
                  ),
                ),
              ],
            )
          : const Scaffold(
              // in portrait mode we can use the standard VehicleList class
              body: VehicleList(),
            ),
    );
  }
}
