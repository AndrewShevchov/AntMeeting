import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stream/utils/colors.dart';
import 'package:stream/widgets/custom_button.dart';
import 'package:stream/widgets/textStyle.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../utils/colors.dart';
import '../widgets/add_task_input_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskProvider _taskController = Get.put(TaskProvider());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "10.00 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Назначить встречу",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            InputTextField(
              title: "Тема встречи",
              hint: "Название темы",
              controller: _titleController,
            ),
            InputTextField(
              title: "Описание",
              hint: "Короткое описание планов",
              controller: _noteController,
            ),
            InputTextField(
              title: "Дата",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: () => {
                  _getDataFromUser(),
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputTextField(
                    title: "Начало встречи",
                    hint: _startTime,
                    widget: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => {
                        _getTimeFromUser(isStartTime: true),
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputTextField(
                    title: "Конец встречи",
                    hint: _endTime,
                    widget: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => {
                        _getTimeFromUser(isStartTime: false),
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPallet(),
                TaskButton(label: "Создать", onTap: () => _validate())
              ],
            ),
          ],
        )),
      ),
    );
  }

  _getDataFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2040));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Значение не может быть нулевым");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    if (_pickedTime != null) {
      String _formatedTime = _pickedTime.format(context);

      if (isStartTime == true) {
        setState(() {
          _startTime = _formatedTime;
        });
      } else if (isStartTime == false) {
        setState(() {
          _endTime = _formatedTime;
        });
      }
    } else {
      print("Время отменено");
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1].split(" ")[0]),
      ),
    );
  }

  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Цвета",
          style: titlestyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? wordLogo
                        : index == 1
                            ? secondaryColor2
                            : card,
                    child: _selectedColor == index
                        ? Icon(Icons.done, color: Colors.white, size: 16)
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _validate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Внимание",
        "Заполните все поля",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appBar,
        icon: Icon(
          Icons.warning_amber,
        ),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("MY id is" + "$value");
  }
}
