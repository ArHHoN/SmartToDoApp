import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category_id INTEGER,
        time TEXT,
        created_at TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL,
        priority INTEGER NOT NULL
      )
    ''');
  }

  // 🟢 CREATE
  Future<int> insertTask(Task task) async {
    final dbClient = await db;
    return await dbClient.insert('tasks', task.toMap());
  }

  // 🔵 READ (All)
  Future<List<Task>> getAllTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query('tasks');
    return result.map((e) => Task.fromMap(e)).toList();
  }

  // 🟡 UPDATE
  Future<int> updateTask(Task task) async {
    final dbClient = await db;
    return await dbClient.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // 🔴 DELETE
  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // ⚪ DELETE ALL (optional)
  Future<void> clearAllTasks() async {
    final dbClient = await db;
    await dbClient.delete('tasks');
  }
}
