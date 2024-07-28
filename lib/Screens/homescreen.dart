import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/Authentication/authentication.dart';
import 'package:task_management_app/Authentication/login.dart';
import 'package:task_management_app/Screens/addTaskScreen.dart';
import 'package:task_management_app/Screens/editTaskScreen.dart';
import 'package:task_management_app/Styles/styles.dart';
import 'package:task_management_app/Widgets/buttons.dart';
import 'package:task_management_app/Widgets/taskTile.dart';
import 'package:task_management_app/Controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
    // notifyHelper.scheduledNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text(
                        "Today",
                        style: headingStyle,
                      )
                    ],
                  ),
                  MyButton(
                      label: "+ Add Task",
                      onTap: () async {
                        // print("Add task button is working !!");
                        await Get.to(() => const Addtaskscreen());
                        _taskController.getTasks();
                      })
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.indigoAccent,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.amberAccent,
      title: const Text(
        "Task Manager",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout,
            size: 25,
          ),
          onPressed: () async {
            await AuthMethod().signOut();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              // print("Hello");
              // return Container(
              //   width: 100,
              //   height: 50,
              //   color: Colors.green,
              // );
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                                // print("Tapped");
                              },
                              child: TaskTile(task),
                            )
                          ],
                        ),
                      ),
                    ));
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                                // print("Tapped");
                              },
                              child: TaskTile(task),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.26
          : MediaQuery.of(context).size.height * 0.33,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // color: Colors.grey,
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: Colors.blue[600]!,
                  context: context),
          const SizedBox(
            height: 3,
          ),
          bottomSheetButton(
              label: "Edit Task",
              onTap: () async {
                await Get.to(() => EditTaskScreen(taskId: task.id));
                _taskController.getTasks();
              },
              clr: Colors.green[600]!,
              context: context),
          const SizedBox(
            height: 3,
          ),
          bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[600]!,
              context: context),
          const SizedBox(
            height: 3,
          ),
          bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.white,
              isClose: true,
              context: context),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }
}
