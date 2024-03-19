import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarAdminView extends StatelessWidget {
  final List<Appointment> appointments;

  const CalendarAdminView({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.workWeek,
      firstDayOfWeek: 1,
      // Setting to show just a certain part of the day, for instance 6 to 20 o'clock
      timeSlotViewSettings: const TimeSlotViewSettings(startHour: 6, endHour: 20),
      dataSource: ResourceDataSource(appointments),
    );
  }
}
// source for retrieving the data of the reservations for each resource
class ResourceDataSource extends CalendarDataSource {
  ResourceDataSource(List<Appointment> source) {
    appointments = source;
  }
}