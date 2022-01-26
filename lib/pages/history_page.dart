import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:flutter_tasks/data/todo_list_model.dart';
import 'package:flutter_tasks/widgets/todo_card.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  final void Function(Todo) delete;
  const HistoryPage({Key? key, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
        selector: (_, model) => model.completedTodos,
        builder: (context, todos, _) {
          todos.sort((t1, t2) => DateTime.parse(t2.completed)
              .compareTo(DateTime.parse(t1.completed)));
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, i) => TodoCard(
                  key: Key(i.toString()),
                  todo: todos[i],
                  onTap: (todo) => delete(todo)));
        });
  }
}
