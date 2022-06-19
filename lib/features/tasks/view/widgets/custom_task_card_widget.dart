import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/date_provider.dart';
import '../../controller/providers/theme_provider.dart';
import '../../data/model/task_model.dart';
import '../screens/details_screen/details_task_screen.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskCardWidget({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    if (taskModel.date ==
            DateFormat.yMd().format(dateProvider.selectedDateFromPicker!) ||
        taskModel.repeat == 'Daily') {
      return _buildTaskCardWidget(context);
    }
    return Container();
  }

  Widget _buildTaskCardWidget(BuildContext context) {
    return Card(
      color: taskModel.color == 0
          ? Colors.indigo
          : taskModel.color == 1
              ? Colors.pink
              : Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsTaskScreen(taskModel: taskModel))),
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.title,
                          color: Colors.grey[200],
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Consumer<ThemeProvider>(
                            builder: (context, provider, child) {
                          return Expanded(
                            child: Text(
                              taskModel.title!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200],
                              ),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.note),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Expanded(
                          child: Text(
                            taskModel.note!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                            ),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<ThemeProvider>(
                            builder: (context, provider, child) {
                          return Text(
                            "Start In : ${taskModel.startTime!}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                            ),
                            softWrap: true,
                            maxLines: 2,
                          );
                        }),
                        Consumer<ThemeProvider>(
                            builder: (context, provider, child) {
                          return Text(
                            "End In : ${taskModel.endTime!}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                            ),
                            softWrap: true,
                            maxLines: 2,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Consumer<ThemeProvider>(
                        builder: (context, provider, child) {
                      return Text(
                        "Repeat : ${taskModel.repeat}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                        softWrap: true,
                      );
                    }),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1 ? "Completed" : "ToDo",
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
