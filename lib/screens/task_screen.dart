import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stream/screens/add_task_screen.dart';
import 'package:stream/widgets/custom_button.dart';
import 'package:stream/widgets/textStyle.dart';

import '../utils/colors.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _addTaskBar(context),
          _addDateBar(),
        ],
      ),
    );
  }
}

_addTaskBar(BuildContext context) {
  addtask() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Сегодня',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        TaskButton(label: "+ Встреча", onTap: () => addtask()),
      ],
    ),
  );
}

_addDateBar() {
  DateTime _selectedDate = DateTime.now();
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 20),
    child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: bottomNav,
      selectedTextColor: Colors.white,
      monthTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(color: Colors.grey),
      ),
      dayTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(color: Colors.grey),
      ),
      dateTextStyle: titlestyle,
      onDateChange: (date) {
        _selectedDate = date;
      },
    ),
  );
}
