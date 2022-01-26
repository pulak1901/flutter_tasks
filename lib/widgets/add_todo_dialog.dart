import 'package:flutter/material.dart';

class AddTodoDialog {
  final _controller = TextEditingController();
  late Function _callback;

  void _send(BuildContext context) {
    _callback(_controller.text);
    Navigator.of(context).pop();
  }

  AddTodoDialog.show(BuildContext context, Function(String) userEntered) {
    _callback = userEntered;

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
            child: Card(
                child: TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter a to do item',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _send(context),
              )),
          onSubmitted: (value) => _send(context),
        )));
      },
    );
  }
}
