import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:flutter_tasks/data/todo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
        selector: (_, model) => model.completedTodos,
        builder: (context, todos, _) {
          todos.sort((t1, t2) => DateTime.parse(t2.completed)
              .compareTo(DateTime.parse(t1.completed)));
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, i) => ListTile(
              key: Key(i.toString()),
              title: Text(todos[i].description),
              subtitle: Text("Created " +
                  timeago.format(DateTime.parse(todos[i].added)) +
                  ", completed " +
                  timeago.format(DateTime.parse(todos[i].completed))),
            ),
          );
        });
  }
}
