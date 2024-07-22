import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return TableCalendar(
      focusedDay: today,
      firstDay: DateTime(2020),
      lastDay: DateTime(2025),
    );
  }
}
