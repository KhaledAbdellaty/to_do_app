import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/notification_provider.dart';
import 'package:to_do_app/widgets/taskList_widget.dart';
import '../database/database_provider.dart';
import '../model/task_model.dart';
import '../providers/date_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskModel> taskList = [];

  TaskModel tModel = TaskModel();

  Future<List<TaskModel>> _getData() async {
    taskList = await DatabaseProvider.instance.readAllElements();
    return taskList.isEmpty ? [] : taskList;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<List<TaskModel>>(
          future: _getData(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  addTaskBar(context),
                  addDateBar(context),
                  Expanded(child: TaskList()),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }

  appBar(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return AppBar(
      elevation: 10,
      leading: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return Consumer<NotificationProvider>(
              builder: (context, notify, child) {
            return IconButton(
              onPressed: () {
                provider.changeTheme();
                notify.showNotification(
                  title: "Theme Changed",
                  body: theme.isDark
                      ? "Activated Dark Mode"
                      : "Activated Light Mode",
                );
                notify.scheduledNotification();
              },
              icon: Icon(theme.isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round),
            );
          });
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

  addTaskBar(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.lato(
                  color: theme.isDark ? Colors.grey[200] : Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Today",
                style: GoogleFonts.lato(
                  color: theme.isDark ? Colors.grey[200] : Colors.grey[800],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          MyButton(
            icon: const Icon(Icons.add),
            label: "Add Task",
          ),
        ],
      ),
    );
  }

  addDateBar(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<DateProvider>(builder: (context, dateProvider, child) {
          return (DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.indigo,
            selectedTextColor: Colors.white,
            monthTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            dayTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            dateTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            onDateChange: (date) {
              dateProvider.selectedDate = date;
              setState(() {

              });
              print(dateProvider.selectedDate);
            },
          ));
        }),
      ),
    );
  }
}
