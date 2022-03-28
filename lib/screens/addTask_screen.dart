import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/database_provider.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/providers/notification_provider.dart';
import 'package:to_do_app/widgets/date_form_Field.dart';
import 'package:to_do_app/widgets/text_form_field.dart';
import '../providers/date_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/colorIcons.dart';
import '../widgets/dropDown.dart';
import '../widgets/endTime_form_field.dart';
import '../widgets/hour_form_field.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  get notification => null;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TaskModel _taskModel = TaskModel();
  bool isNew = false;
  late MyDropDown dropItem;


  addTask() {
    final int _isCompleted = 0;
    _key.currentState?.save();
    DatabaseProvider.instance.createTask(TaskModel(
      title: _titleController.text,
      note: noteController.text,
      date: _dateController.text,
      startTime: _startDateController.text,
      endTime: _endDateController.text,
      repeat: _repeatController.text,
      color: int.parse(_colorController.text),
      isCompleted: _isCompleted,

    ));
    print("Added Task");
    print(_startDateController.text);
    print(_endDateController.text);
    print(_dateController.text);
    print(_colorController.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final dateProvider = Provider.of<DateProvider>(context);

    return Scaffold(
      appBar: appBar(),
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
                  style: GoogleFonts.lato(
                    color: theme.isDark ? Colors.grey[200] : Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyFormField(
                  label: "Title",
                  controller: _titleController,
                  tModel: _taskModel,
                ),
                MyFormField(
                  label: "Note",
                  controller: noteController,
                  tModel: _taskModel,
                ),
                MyDatePicker(
                  label: "Date",
                  controller: _dateController,
                  icon: const Icon(Icons.date_range),
                ),
                Row(
                  children: [
                    Expanded(
                        child: HourDatePicker(
                      hint: dateProvider.chooseHour.format(context),
                      label: "Start Date",
                      controller: _startDateController,
                      icon: const Icon(Icons.access_time_rounded),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: MyEndTimePicker(
                      hint: dateProvider.chooseEndHour.format(context),
                      label: "End Date",
                      controller: _endDateController,
                      icon: const Icon(Icons.access_time_rounded),
                    )),
                  ],
                ),
                dropItem = MyDropDown(
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
                ColorIcons(passColor: _colorController,),
                Consumer<NotificationProvider>(
                  builder: (context,provider,child){
                    return ElevatedButton(
                    onPressed: () {
                      addTask();
                      provider.showNotification(title: 'You Added New Task', body: 'With Title Name : ${_titleController.text}');
                      Navigator.pop(context);
                    },
                    child: const Text("Create Task"),
                  );},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      elevation: 10,
      leading: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
