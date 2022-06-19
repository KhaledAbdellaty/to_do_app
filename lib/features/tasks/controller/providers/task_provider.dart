import 'package:flutter/material.dart';

import '../../data/model/task_model.dart';
import '../../data/repositories/data_repo.dart';

class TaskProvider extends ChangeNotifier {
  final int completedTask = 0;
  Future<List<TaskModel>> getAllTasks() async {
    final tasks = await DataRepoImp.instance.getAllTasks();
    return tasks;
  }

  int completeTask() {
    return completedTask + 1;
  }

  Future<void> addTask(TaskModel task) async {
    await DataRepoImp.instance.addTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int taskId) async {
    await DataRepoImp.instance.deleteTask(taskId);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await DataRepoImp.instance.updateTask(task);
    notifyListeners();
  }
}
