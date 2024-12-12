import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/add_model/add_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todos.db');
    return await openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isDone INTEGER,
        date TEXT,
        time TEXT,
        "order" INTEGER,
        priority TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE todos ADD COLUMN priority TEXT');
    }
  }

  Future<void> insertToDo(ToDo todo) async {
    final db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ToDo>> getToDos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    print(maps);
    return List.generate(maps.length, (i) {
      return ToDo.fromMap(maps[i]);
    });
  }

  Future<void> updateToDo(ToDo todo) async {
    final db = await database;
    await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteToDo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  void updateToDoOrder(List<ToDo> todos) async {
    for (int i = 0; i < todos.length; i++) {
      todos[i].order = i;
    }
    for (var todo in todos) {
      await updateToDo(todo);
    }
  }

  deleteAllToDos() {
    final db = database;
    db.then((value) {
      value.delete('todos');
    });
  }

  void updateToDoStatus(ToDo todo) {
    final db = database;
    db.then((value) {
      value.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
    });
  }
}