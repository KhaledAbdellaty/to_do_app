
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/taskDetails_screen.dart';
import '../database/database_provider.dart';
import '../model/task_model.dart';
import '../providers/date_provider.dart';
import '../providers/theme_provider.dart';

class TaskList extends StatelessWidget {
  TaskList({Key? key}) : super(key: key);
  List<TaskModel> taskList = [];
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // final Tween<Offset> _offset = Tween(begin: Offset(1,0),end: Offset(0,0));
  @override
  Widget build(BuildContext context) {
    return getAllTasks();
  }

  getAllTasks() {

    return FutureBuilder<List<TaskModel>>(
      future: _getData(),
      builder: (context, snapshot) {
        return createListView(context, snapshot);
      },
    );
  }

  Future<List<TaskModel>> _getData() async {
    taskList = await DatabaseProvider.instance.readAllElements();
    return taskList.isEmpty ? [] : taskList;
  }

  createListView(BuildContext context, AsyncSnapshot snapshot) {
    final theme = Provider.of<ThemeProvider>(context);
    if (snapshot.hasData) {
      taskList = snapshot.data;
    }
    return taskList.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              //return ;
              return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    decoration: BoxDecoration(
                      color: theme.isDark ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onDismissed: (direction) =>
                      DatabaseProvider.instance.deleteTask(taskList[index].id),
                  child: buildItem(context, taskList[index], index),
                );
                },
              )
        :Container();
  }

  buildItem(BuildContext context, TaskModel taskModel, int index) {
    final theme = Provider.of<ThemeProvider>(context);
    final date = Provider.of<DateProvider>(context);
    if(taskModel.date == DateFormat.yMd().format(date.selectedDate)){
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
                builder: (context) => TaskDetails(taskModel: taskList[index]))),
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
                        // Consumer<ThemeProvider>(builder: (context, provider, child) {
                        //   return Text(
                        //     taskModel.date!,
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.grey[200],
                        //     ),
                        //     softWrap: true,
                        //     maxLines: 2,
                        //   );
                        // }),
                        // const SizedBox(height: 5),
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
    if(taskModel.repeat == 'Daily'){return Card(
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
            builder: (context) => TaskDetails(taskModel: taskList[index]))),
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
                    // Consumer<ThemeProvider>(builder: (context, provider, child) {
                    //   return Text(
                    //     taskModel.date!,
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey[200],
                    //     ),
                    //     softWrap: true,
                    //     maxLines: 2,
                    //   );
                    // }),
                    // const SizedBox(height: 5),
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
    );}
    else{
      return Container();
    }
  }
}
