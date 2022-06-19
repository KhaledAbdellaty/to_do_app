
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/theme_provider.dart';
import '../../../../data/model/task_model.dart';

class DetailsHeaderWidget extends StatelessWidget {
  final TaskModel taskModel;
  const DetailsHeaderWidget({Key? key ,required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: taskModel.color == 0
                        ? themeProvider.isDark
                            ? Colors.white
                            : Colors.indigo
                        : taskModel.color == 1
                            ? themeProvider.isDark
                                ? Colors.white
                                : Colors.pink
                            : themeProvider.isDark
                                ? Colors.white
                                : Colors.deepPurple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Start in : ${taskModel.startTime}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: taskModel.color == 0
                        ? themeProvider.isDark
                            ? Colors.white
                            : Colors.indigo
                        : taskModel.color == 1
                            ? themeProvider.isDark
                                ? Colors.white
                                : Colors.pink
                            : themeProvider.isDark
                                ? Colors.white
                                : Colors.deepPurple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'End in : ${taskModel.endTime}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: taskModel.color == 0
                      ? themeProvider.isDark
                          ? Colors.white
                          : Colors.indigo
                      : taskModel.color == 1
                          ? themeProvider.isDark
                              ? Colors.white
                              : Colors.pink
                          : themeProvider.isDark
                              ? Colors.white
                              : Colors.deepPurple,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'In Date : ${taskModel.date}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            )
      ],
    );
  }
}
