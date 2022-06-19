import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../awesome_notification/notification_init.dart';
import '../../../controller/providers/date_provider.dart';
import '../../../controller/providers/task_provider.dart';
import '../../../controller/providers/theme_provider.dart';
import '../../../data/model/task_model.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_time_picker.dart';
import 'widgets/color_picker_widget.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _colorController =
      TextEditingController(text: '0');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isNew = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: TextStyle(
                    color: themeProvider.isDark
                        ? Colors.grey[200]
                        : Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextFormField(
                  label: "Title",
                  controller: _titleController,
                ),
                CustomTextFormField(
                  label: "Note",
                  controller: _noteController,
                ),
                CustomDateChoosePicker(
                  label: "Date",
                  controller: _dateController,
                  icon: const Icon(Icons.date_range),
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomStartTimeChoosePicker(
                      hint: dateProvider.chooseHour.format(context),
                      label: "Start Date",
                      controller: _startDateController,
                      icon: const Icon(Icons.access_time_rounded),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomEndTimeChoosePicker(
                      hint: dateProvider.chooseEndHour.format(context),
                      label: "End Date",
                      controller: _endDateController,
                      icon: const Icon(Icons.access_time_rounded),
                    )),
                  ],
                ),
                CustomDropDown(
                  label: 'Rebeat',
                  controller: _repeatController,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text("Color"),
                const SizedBox(
                  height: 8,
                ),
                ColorPickerWidget(
                  passColor: _colorController,
                ),
                ElevatedButton(
                  onPressed: () {
                    addTask(context);
                    /**/
                  },
                  child: const Text("Create Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTask(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _key.currentState?.save();
    final taskModel = TaskModel(
      title: _titleController.text,
      note: _noteController.text,
      date: _dateController.text,
      startTime: _startDateController.text,
      endTime: _endDateController.text,
      repeat: _repeatController.text,
      color: int.parse(_colorController.text),
      isCompleted: taskProvider.completedTask,
    );
    taskProvider.addTask(taskModel);
    MyNotifications.instance.createNotification(
      title: 'You Added New Task ',
      body: 'With Title Name : ${_titleController.text}',
    );
    MyNotifications.instance.createScheduleNotification(
      title: 'You Have Task Now ..',
      body: 'You should make that : ${taskModel.title} ',
      context: context,
    );

    Navigator.pop(context);
    print("Added Task");
    print(_startDateController.text);
    print(_endDateController.text);
    print(_dateController.text);
    print(_colorController.text);
  }
}
