import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:flutter_tasks/data/todo_list_model.dart';
import 'package:flutter_tasks/widgets/todo_card.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  final void Function(Todo todo) complete;
  final void Function(int oldIndex, int newIndex) swap;
  const TodoPage({Key? key, required this.complete, required this.swap})
      : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
        selector: (_, model) => model.todos,
        builder: (context, todos, _) {
          return ReorderableListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return TodoCard(
                    key: Key(index.toString()),
                    todo: todo,
                    onTap: (todo) => widget.complete(todo));
              },
              onReorder: (int oldIndex, int newIndex) =>
                  widget.swap(oldIndex, newIndex));
        },
        shouldRebuild: (oldTodos, newTodos) => !listEquals(oldTodos, newTodos));
  }
}
