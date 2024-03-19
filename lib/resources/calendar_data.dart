import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// collecting icons and colors for displaying in ResourceView - portrait mode
List<Icon> getAllPortraitResources(List<Appointment> appointments) {
  List<Icon> resources = [];
  // fullscreen icon
  resources.add(
    const Icon(
      Icons.fullscreen,
      size: 24,
      color: Colors.blueGrey,
      shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(2, 2),
          blurRadius: 2,
        ),
      ],
    ),
  );
  // other icons
  for (int i = 0; i < appointments.length; i++) {
    IconData iconData = Icons.directions_bus_filled; // Default to the bus icon
    if (appointments[i].subject.contains('Car')) {
      iconData = Icons.directions_car_filled;
    } else if (appointments[i].subject.contains('Truck')) {
      iconData = Icons.local_shipping;
    } else if (appointments[i].subject.contains('Van')) {
      iconData = Icons.airport_shuttle;
    } else if (appointments[i].subject.contains('Motorcycle')) {
      iconData = Icons.two_wheeler;
    } else if (appointments[i].subject.contains('Bicycle')) {
      iconData = Icons.directions_bike;
    }
    // Create an Icon with the selected icon and appointment color and add it to the resources
    resources.add(
      Icon(
        iconData,
        size: 24,
        color: appointments[i].color,
        shadows: const [
          Shadow(
            color: Colors.black38,
            offset: Offset(2, 2),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }
  return resources;
}

// collecting icons and colors and info for displaying in WideResourceView - landscape mode
List<Widget> getAllLandscapeResources(List<Appointment> appointments) {
  List<Widget> resources = [];
  // icons + additional info
  for (int i = 0; i < appointments.length; i++) {
    resources.add(
      Row(
        children: [
          Icon(
            getIconForAppointment(appointments[i]),
            size: 24,
            color: appointments[i].color,
            shadows: const [
              Shadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ],
          ),
          const SizedBox(width: 8),
          Text(
            appointments[i].subject,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
  return resources;
}

// Method for retrieving the correct icon for the resource calendar
IconData getIconForAppointment(Appointment appointment) {
  if (appointment.subject.contains('Car')) {
    return Icons.directions_car_filled;
  } else if (appointment.subject.contains('Truck')) {
    return Icons.local_shipping;
  } else if (appointment.subject.contains('Van')) {
    return Icons.airport_shuttle;
  } else if (appointment.subject.contains('Motorcycle')) {
    return Icons.two_wheeler;
  } else if (appointment.subject.contains('Bicycle')) {
    return Icons.directions_bus_filled;
  } else {
    return Icons.directions_bus_filled;
  }
}

// testdata: appointments to display in the calendar view
List<Appointment> getAllAppointments() {
  return [
    ...getAppointmentsFor('Bus: 1-VXL-009', Colors.blue, 2, 6),
    ...getAppointmentsFor('Bus: 1-POK-544', Colors.brown, 2, 16),
    ...getAppointmentsFor('Truck: 1-DEF-456', Colors.red, 2, 10),
    ...getAppointmentsFor('Truck: 1-TRU-457', Colors.purple, 2, 14),
    ...getAppointmentsFor('Van: 1-GHI-789', Colors.orange, 2, 12),
    ...getAppointmentsFor('Car: 1-ABC-123', Colors.green, 2, 8),
  ];
}

// generate some appointments for a resource
List<Appointment> getAppointmentsFor(
    String subject, Color color, int durationHours, int startHour) {
  final List<Appointment> meetings = [];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(
    today.year,
    today.month,
    today.day,
    startHour,
  );
  final DateTime endTime = startTime.add(Duration(hours: durationHours));
  meetings.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      color: color,
      recurrenceRule: 'FREQ=DAILY;COUNT=5',
    ),
  );
  return meetings;
}
