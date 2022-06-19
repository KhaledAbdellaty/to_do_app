import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/strings.dart';

abstract class DataServices {
  Future<Database> initDatabase();
  Future<void> createDatabase(Database database, int version);
  Future<void> addTask(Map<String, dynamic> data);
  Future<void> updateTask(Map<String, dynamic> data, int taskId);
  Future<void> deleteTask(int taskId);
  Future<List<dynamic>> getAllTasks();
}

class DataServicesImp extends DataServices {
  DataServicesImp._();
  static final DataServicesImp instance = DataServicesImp._();
  Database? _database;
  Future<Database>? get database async {
    if (_database != null) _database;
    _database = await initDatabase();
    return _database!;
  }

  @override
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'TaskDatabase');
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  @override
  Future<void> createDatabase(Database database, int version) async {
    await database.execute('''
    CREATE TABLE $tableTask(
    $columnId $idType, 
    $columnTitle $textType,
    $columnNote $textType,
    $columnDate $textType, 
    $columnStartTime $textType,
    $columnRepeat $textType,
    $columnEndTime $textType,
    $columnColor $intType,
    $columnIsCompleted $intType)
    ''');
  }

  @override
  Future<void> addTask(Map<String, dynamic> data) async {
    try {
      final db = await instance.database;
      db!.insert(
        tableTask,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw 'Error on Add Task $e';
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    try {
      final db = await instance.database;
      db!.delete(
        tableTask,
        where: '$columnId = ?',
        whereArgs: [taskId],
      );
    } catch (e) {
      throw 'Error on Delete Task $e';
    }
  }

  @override
  Future<List<dynamic>> getAllTasks() async {
    try {
      final db = await instance.database;
      final tasks = db!.query(tableTask);
      return tasks;
    } catch (e) {
      throw 'Error on Get All Tasks $e';
    }
  }

  @override
  Future<void> updateTask(Map<String, dynamic> data, int taskId) async {
    try {
      final db = await instance.database;
      db!.update(
        tableTask,
        data,
        where: '$columnId = ?',
        whereArgs: [taskId],
      );
    } catch (e) {
      throw 'Error on Update Task $e';
    }
  }
}
