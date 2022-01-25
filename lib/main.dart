import 'package:flutter/material.dart';
import 'package:flutter_tasks/pages/history_page.dart';
import 'package:flutter_tasks/pages/todo_page.dart';
import 'package:flutter_tasks/widgets/custom_bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;

  _pageSelected(int _index) {
    setState(() {
      _page = _index;
    });
  }

  _getPage(int _index) {
    if (_page == 1) {
      return HistoryPage();
    } else {
      return TodoPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: _getPage(_page)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
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
