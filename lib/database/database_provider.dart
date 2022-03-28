import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/database/constants.dart';
import 'package:to_do_app/model/task_model.dart';

class DatabaseProvider extends ChangeNotifier {
  static final DatabaseProvider instance = DatabaseProvider._init();

  DatabaseProvider._init();

  static Database? _database;

  Future<Database>? get database async {
    if (_database != null) _database;
    _database = await _initDB();
    return _database!;
  }

  Future<Database>? _initDB() async {
    String path = join(await getDatabasesPath(), 'TaskDatabase.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database database, int version) async {
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

    //
    // $columnRemind $textType,
    // $columnRepeat $textType,
    //
  }

  /// CRUD

  // Update
  Future<void> updateTask(TaskModel taskModel) async {
    final db = await instance.database;
    db!.update(
      tableTask,
      taskModel.toMap(),
      where: '$columnId = ?',
      whereArgs: [taskModel.id],
    );
    notifyListeners();
  }
  Future<void> updateOneTask(TaskModel taskModel) async {
    final db = await instance.database;
    db!.update(
      tableTask,
      taskModel.toChange(),
      where: '$columnId = ?',
      whereArgs: [taskModel.id],
    );
    notifyListeners();
  }

  // Create
  Future<void> createTask(TaskModel taskModel) async {
    final db = await instance.database;
    db!.insert(
      tableTask,
      taskModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  // Delete
  Future<void> deleteTask(int? id) async {
    final db = await instance.database;
    db!.delete(
      tableTask,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Read One Element
  Future<TaskModel> readOneElement(int? id) async {
    final db = await instance.database;
    final data = await db!.query(
      tableTask,
      where: '$columnId ? =',
      whereArgs: [id],
    );
    return data.isNotEmpty
        ? TaskModel.fromMap(data.first)
        : throw Exception('There is no Data');
  }

  // Read All Elements
  Future<List<TaskModel>> readAllElements() async {
    final db = await instance.database;
    final data = await db!.query(tableTask);
    return data.isNotEmpty
        ? data.map((e) => TaskModel.fromMap(e)).toList()
        : [];
  }
}
