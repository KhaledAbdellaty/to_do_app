
import '../model/task_model.dart';
import '../services/data_services.dart';

abstract class DataRepo {
  Future<void> addTask(TaskModel taskModel);
  Future<void> updateTask(TaskModel taskModel);
  Future<void> deleteTask(int taskId);
  Future<List<TaskModel>> getAllTasks();
}

class DataRepoImp extends DataRepo {
  DataRepoImp._();
  static final DataRepoImp instance = DataRepoImp._();
  @override
  Future<void> addTask(TaskModel taskModel) async {
    await DataServicesImp.instance.addTask(taskModel.toMap());
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await DataServicesImp.instance.deleteTask(taskId);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final tasks = await DataServicesImp.instance.getAllTasks();
    final List<TaskModel> tasksFromMap =
        tasks.map<TaskModel>((task) => TaskModel.fromMap(task)).toList();
    return tasksFromMap;
  }

  @override
  Future<void> updateTask(TaskModel taskModel) async {
    await DataServicesImp.instance
        .updateTask(taskModel.toChange(), taskModel.id!);
  }
}
