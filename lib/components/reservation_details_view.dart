import 'package:flutter/material.dart';
import 'package:fleetmanager/services/fetch_reservation_with_reservation_id_service.dart';
class SingleReservationDetailsView extends StatelessWidget {
  final String defaultReservationId = 'dxCfBsPzd7dMWlJptPxp';

  const SingleReservationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchReservation(defaultReservationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No reservation found.'));
          } else {
            // Reservation data is available
            Map<String, dynamic> reservationInfo = snapshot.data!;
            Map<String, dynamic> reservationData = reservationInfo['reservationData'];
            DateTime startTime = reservationInfo['startTime'];
            DateTime endTime = reservationInfo['endTime'];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reservation Details', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 16.0),
                  Text('Start Time: ${startTime.toString()}'),
                  Text('End Time: ${endTime.toString()}'),
                  // Display other reservation details here
                ],
              ),
            );
          }
        },
      ),
    );
  }
}