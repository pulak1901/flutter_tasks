import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:timeago/timeago.dart' as timeago;

class TodoCard extends StatelessWidget {
  Todo todo;
  Function(Todo) onTap;

  TodoCard({Key? key, required this.todo, required this.onTap})
      : super(key: key);

  String _getTodoTime() {
    String result = "Created " + timeago.format(DateTime.parse(todo.added));
    if (todo.completed == '') {
      return result;
    }

    result += ", completed " + timeago.format(DateTime.parse(todo.completed));
    return result;
  }

  Widget _getButton() {
    if (todo.completed == '') {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
        child: const Icon(Icons.check),
      );
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
        child: const Icon(Icons.delete, color: Colors.white),
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: Card(
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () => onTap(todo),
                  child: _getButton(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.description,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(_getTodoTime(), style: const TextStyle(fontSize: 13))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
