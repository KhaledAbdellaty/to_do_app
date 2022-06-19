import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/date_provider.dart';
import '../../../../controller/providers/task_provider.dart';
import '../../../../controller/providers/theme_provider.dart';
import '../../../../data/model/task_model.dart';
import '../../../widgets/custom_task_card_widget.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final tasksProvider = Provider.of<TaskProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<TaskModel> tasksList;
    String? taskDate;
    String? taskRepeat;
    return FutureBuilder<List<TaskModel>>(
      future: tasksProvider.getAllTasks(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          tasksList = snapshot.data!;
          if (tasksList.isNotEmpty) {
            return Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDark
                          ? Colors.grey[800]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onDismissed: (direction) =>
                      tasksProvider.deleteTask(tasksList[index].id!),
                  child: TaskCardWidget(
                    taskModel: tasksList[index],
                  ),
                );
              },
            ));
          } else {
            return const Expanded(
              child: Center(
                child: Text(
                  'No Tasks',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          }
        } else {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

       
      }),
    );
  }
}
