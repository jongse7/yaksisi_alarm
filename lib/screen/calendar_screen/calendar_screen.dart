// 2번. 달력 페이지

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'widget/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(// 날짜 overflow 방지 코드
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Calendar(
            selectedDay: selectedDay,
            focusedDay: focusedDay,
            onDaySelected: onDaySelected,
          ),
        ));
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
