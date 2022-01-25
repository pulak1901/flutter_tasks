import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class TodoDatabase extends ChangeNotifier {
  final String database = "todo.db";
  final String table = "todos";

  late Database _db;

  TodoDatabase() {
    _init();
  }

  void _init() async {
    openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, idx INTEGER, description TEXT, added TEXT, completed TEXT)');
    }, version: 1)
        .then((value) {
      _db = value;
      notifyListeners();
    });
  }

  void dropTable() async {
    _db.execute('DROP TABLE todos').then((_) => print("Dropped table todos!"));
  }

  Future<int> insertTodo(Todo todo) async {
    return _db.insert(table, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.update(
      table,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> loadTodos() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);

    print("Loaded ${maps.length} todos!");
    for (int i = 0; i < maps.length; i++) {
      print(maps[i]);
    }
    return List.generate(maps.length, (i) {
      return Todo(
          id: maps[i]['id'],
          index: maps[i]['idx'],
          description: maps[i]['description'],
          added: maps[i]['added'],
          completed: maps[i]['completed']);
    });
  }

  void saveTodos(List<Map<String, dynamic>> todos) async {
    print("Current todos table state:");
    for (int i = 0; i < todos.length; i++) {
      print(todos[i]);
      await _db.insert(table, todos[i],
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  void deleteTodos() async {
    await _db.delete(table, where: null);
    print("Deleted all Todos!");
  }
}
