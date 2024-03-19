import 'package:fleetmanager/resources/app_theme.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:fleetmanager/services/widget_property_container_service.dart';
import 'package:fleetmanager/services/vehicle_data_service.dart';
import 'package:provider/provider.dart';

class ShowVehicleDetailsView extends StatelessWidget {
  final VehicleDataService vehicleDataService = VehicleDataService();
  final String vehicleId;

  ShowVehicleDetailsView({Key? key, required this.vehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Vehicle ID from the vehicle you want to get the data from
    String vehicleId = this.vehicleId;
    // get the users settings for the theme
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Function to fetch data for the vehicle and its references
    Future<Map<String, dynamic>> fetchVehicleData() async {
      return await vehicleDataService.fetchVehicleData(vehicleId);
    }

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchVehicleData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic>? data = snapshot.data;
              String licensePlate = data?['vehicleData']['licensePlate'] ?? '';
              String type = data?['vehicleData']['type'] ?? '';
              int numberOfSeats = data?['vehicleData']['numberOfSeats'] ?? 0;
              double maxLoad = data?['vehicleData']['maxLoad'] ?? 0.0;
              String driverName = data?['driverData']['name'] ?? '';
              String driverEmail = data?['driverData']['email'] ?? '';
              String driverPhone = data?['driverData']['phone'] ?? '';
              String garageName = data?['garageData']['name'] ?? '';
              String garageStreet = data?['garageData']['street'] ?? '';
              String garageNumber =
                  data?['garageData']['number'].toString() ?? '';
              String garageCity = data?['garageData']['city'] ?? '';
              String garageZip =
                  data?['garageData']['zipcode'].toString() ?? '';
              String garageCountry = data?['garageData']['country'] ?? '';
              String garagePhone = data?['garageData']['phone'] ?? '';
              double containerWidth(BuildContext context) {
                return MediaQuery.of(context).size.width - 32;
              }

              // set the propertyContainers borderColor = to the users theme prefference
              Color borderColor = themeProvider.isDarkMode
                  ? AppTheme.darkTheme.primaryColor
                  : AppTheme.lightTheme.primaryColor;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display vehicle information in a single container
                      propertyContainer(
                          "Vehicle Information",
                          """
                        License Plate: $licensePlate
                        Type: $type
                        Number of Seats: $numberOfSeats
                        Max Load: ${maxLoad.toStringAsFixed(2)}
                        """,
                          containerWidth(context),
                          borderColor),
                      const SizedBox(height: 8.0),
                      // Display the driver information in a single container
                      propertyContainer(
                          "Driver Information",
                          """
                        Name: $driverName
                        Phone: $driverPhone
                        Email: $driverEmail
                        """,
                          containerWidth(context),
                          borderColor),
                      const SizedBox(height: 8.0),
                      // Display the garage information in a single container
                      propertyContainer(
                          "Garage Information",
                          """
                        Garage: $garageName
                        Address: $garageStreet $garageNumber
                        City: $garageZip $garageCity
                        Country: $garageCountry
                        Phone: $garagePhone
                        """,
                          containerWidth(context),
                          borderColor),
                    ],
                  ),
                ),
              );
            } else {
              return const Text("Data not found");
            }
          } else {
            // show loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
