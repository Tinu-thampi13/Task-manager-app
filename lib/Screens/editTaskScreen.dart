import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/Styles/styles.dart';
import 'package:task_management_app/Widgets/buttons.dart';
import 'package:task_management_app/Widgets/input_field.dart';
import 'package:task_management_app/Controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color greenClr = Colors.green;
const Color purpleClr = Colors.purpleAccent;
const Color tealClr = Colors.tealAccent;
const Color orangeClr = Color.fromARGB(255, 237, 144, 4);

class EditTaskScreen extends StatefulWidget {
  int? taskId;
  EditTaskScreen({super.key, required this.taskId});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TaskController _taskController = Get.put(TaskController());
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter the Title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter the Note",
                controller: _noteController,
              ),
              MyInputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                      onPressed: () {
                        _getDateFromUser();
                      },
                      icon: const Icon(Icons.calendar_today,
                          color: Colors.grey))),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: MyInputField(
                    title: "End Date",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                    ),
                  ))
                ],
              ),
              MyInputField(
                  title: "Remind",
                  hint: "$_selectedRemind minutes early",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString(),
                              style: const TextStyle(color: Colors.black)));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    underline: Container(
                      height: 0,
                    ),
                  )),
              MyInputField(
                  title: "Repeat",
                  hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value!,
                            style: const TextStyle(color: Colors.black),
                          ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    underline: Container(
                      height: 0,
                    ),
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: List<Widget>.generate(7, (int index) {
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
                                    ? orangeClr
                                    : index == 1
                                        ? yellowClr
                                        : index == 2
                                            ? tealClr
                                            : index == 3
                                                ? pinkClr
                                                : index == 4
                                                    ? bluishClr
                                                    : index == 5
                                                        ? greenClr
                                                        : purpleClr,
                                child: _selectedColor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: GestureDetector(
                onTap: () {
                  _validateData();
                  // print("Create task button is working !!");
                },
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigoAccent),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Update Task",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // print("validateData working !!");
      _editTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !!",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _editTaskToDb() async {
    _taskController.edit(Task(
      id: widget.taskId,
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
    // int value = await _taskController.addTask(
    //     task: Task(
    //   id: 1,
    //   note: _noteController.text,
    //   title: _titleController.text,
    //   date: DateFormat.yMd().format(_selectedDate),
    //   startTime: _startTime,
    //   endTime: _endTime,
    //   remind: _selectedRemind,
    //   repeat: _selectedRepeat,
    //   color: _selectedColor,
    //   isCompleted: 0,
    // ));

    // print("My id is " + "$value");
  }

  _appBar(BuildContext context) {
    return AppBar();
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context, firstDate: DateTime(2015), lastDate: DateTime(2115));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Invalid Date");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
