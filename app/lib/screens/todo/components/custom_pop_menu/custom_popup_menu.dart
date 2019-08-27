import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';

enum TodoTileMenuOptions { Brief, Archive }

class CustomPopupMenu extends StatefulWidget {
  CustomPopupMenu(
      {@required this.entry,
      @required this.index,
      this.onArchive,
      this.onBrief});
  final TodoItem entry;
  final int index;
  final Function onArchive;
  final Function onBrief;
  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  // Private member variables
  TodoTileMenuOptions _mSelectedOption;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TodoTileMenuOptions>(
      onSelected: (TodoTileMenuOptions result) {
        this.setState(() {
          _mSelectedOption = result;
        });
        switch (this._mSelectedOption) {
          case TodoTileMenuOptions.Brief:
            widget.onBrief(widget.index);
            break;
          default:
            widget.onArchive(widget.index, widget.entry);
        }
      },
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<TodoTileMenuOptions>>[
        const PopupMenuItem<TodoTileMenuOptions>(
            child: Text(
              "Brief",
            ),
            value: TodoTileMenuOptions.Brief),
        const PopupMenuItem<TodoTileMenuOptions>(
            child: Text("Archive"), value: TodoTileMenuOptions.Archive),
      ],
    );
  }
}
