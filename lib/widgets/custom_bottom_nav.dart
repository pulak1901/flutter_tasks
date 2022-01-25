// https://medium.com/coding-with-flutter/flutter-bottomappbar-navigation-with-fab-8b962bb55013

import 'package:flutter/material.dart';

class CustomNavItem {
  IconData icon;
  String label;

  CustomNavItem({required this.icon, required this.label});
}

class CustomBottomNav extends StatefulWidget {
  final List<CustomNavItem> items;
  final Color color;
  final Color selectedColor;
  final double iconSize;
  final double height;
  final String fabLabel;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNav(
      {Key? key,
      required this.color,
      required this.selectedColor,
      required this.items,
      required this.iconSize,
      required this.height,
      required this.fabLabel,
      required this.onTabSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomBottomNavState();
}

class CustomBottomNavState extends State<CustomBottomNav> {
  int _selected = 0;

  _update(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
        widget.items.length,
        (index) => _buildItem(
            item: widget.items[index], index: index, onPressed: _update));

    items.insert(items.length >> 1, _buildFABItem());

    return BottomAppBar(
        shape: const CircularNotchedRectangle(), child: Row(children: items));
  }

  Widget _buildItem(
      {required Function(int index) onPressed,
      required int index,
      required CustomNavItem item}) {
    Color color = _selected == index ? widget.selectedColor : widget.color;

    return Expanded(
        child: SizedBox(
            height: widget.height,
            child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    onTap: () => onPressed(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, color: color, size: widget.iconSize),
                        Text(
                          item.label,
                          style: TextStyle(color: color),
                        )
                      ],
                    )))));
  }

  Widget _buildFABItem() {
    return Expanded(
        child: SizedBox(
      height: widget.height,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: widget.iconSize),
            Text(
              widget.fabLabel,
              style: TextStyle(color: widget.color),
            )
          ]),
    ));
  }
}
