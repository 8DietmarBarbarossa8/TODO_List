import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbName = 'task.db';
    final path = join(dbpath, dbName);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableTasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${TaskFields.taskName} TEXT,
          ${TaskFields.data} TEXT,
          ${TaskFields.isStarred} INTEGER,
          ${TaskFields.isCompleted} INTEGER)
    ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(tableTasks, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    db.update(
      tableTasks,
      task.toMap(),
      where: 'id == ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;
    db.delete(
      tableTasks,
      where: 'id == ?',
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> getTask() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      tableTasks,
      orderBy: 'id ASC',
    );
    return List.generate(
        items.length,
        (i) => Task(
              id: items[i][TaskFields.id],
              taskName: items[i][TaskFields.taskName],
              data: DateTime.parse(items[i][TaskFields.data]),
              isStarred: items[i][TaskFields.isStarred] == 1 ? true : false,
              isCompleted: items[i][TaskFields.isCompleted] == 1 ? true : false,
            ));
  }
}
