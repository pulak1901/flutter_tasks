import 'package:flutter/material.dart';
import 'package:flutter_tasks/data/todo.dart';
import 'package:flutter_tasks/data/todo_db.dart';
import 'package:flutter_tasks/data/todo_list_model.dart';
import 'package:flutter_tasks/pages/history_page.dart';
import 'package:flutter_tasks/pages/todo_page.dart';
import 'package:flutter_tasks/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TodoDatabase db = TodoDatabase();
  TodoListModel model = TodoListModel(db: db);

  runApp(MyApp(model: model));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.model}) : super(key: key);
  final TodoListModel model;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider.value(
        value: model,
        builder: (context, _) => MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  late HistoryPage historyPage = HistoryPage();
  late TodoPage todoPage;
  late TodoListModel _model;

  @override
  void initState() {
    super.initState();
    todoPage = TodoPage(
      complete: _completeTodo,
      swap: _swapTodo,
    );
  }

  _pageSelected(int _index) {
    setState(() {
      _page = _index;
    });
  }

  _getPage(int _index) {
    if (_page == 1) {
      return historyPage;
    } else {
      return todoPage;
    }
  }

  _completeTodo(Todo todo) {
    _model.complete(todo.id);
  }

  _swapTodo(int oldIndex, int newIndex) {
    _model.swap(oldIndex, newIndex);
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<TodoListModel>(context, listen: true);
    return Scaffold(
        body: SafeArea(child: _getPage(_page)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {_model.add("description", 0)},
          tooltip: 'Add todo',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNav(
          color: Colors.black,
          selectedColor: Colors.blue,
          iconSize: 28.0,
          height: 64.0,
          fabLabel: "Add",
          items: [
            CustomNavItem(icon: Icons.list, label: "Todo"),
            CustomNavItem(icon: Icons.stacked_line_chart, label: "History")
          ],
          onTabSelected: (index) => {_pageSelected(index)},
        ));
  }
}
