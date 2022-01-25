import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:flutter_tasks/data/todo_db.dart';

class TodoListModel extends ChangeNotifier {
  final TodoDatabase db;

  TodoListModel({required this.db}) {
    db.addListener(() {
      load().then((value) => notifyListeners());
    });
  }

  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _saveTodos() {
    List<Map<String, dynamic>> todos = [];
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].index = i;
      todos.add(_todos[i].toMap());
    }
    db.saveTodos(todos);
  }

  void _deleteTodos() {
    db.deleteTodos();
  }

  Future load() {
    _isLoading = true;
    notifyListeners();

    return db.loadTodos().then((loadedTodos) {
      _todos.addAll(loadedTodos);
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void add(String description, int index) async {
    final todo = Todo.create(description, index);
    int id = await db.insertTodo(todo);
    todo.id = id;
    _todos.insert(index, todo);
    _saveTodos();
    notifyListeners();
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex == todos.length) newIndex--;

    final temp = todos.removeAt(oldIndex);
    todos.insert(newIndex, temp);

    _saveTodos();

    notifyListeners();
  }

  void complete(int? id) {
    if (id == null) {
      print("wtf");
    }
    final todo = todos.where((td) => td.id == id).first;
    todo.completed = DateTime.now().toIso8601String();

    _saveTodos();
    notifyListeners();
  }
}
