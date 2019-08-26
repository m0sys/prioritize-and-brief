import 'package:flutter/material.dart';
import 'package:todo_list/components/form_panel/form_panel.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/screens/brief_screen/components/brief_logo.dart';

class BriefScreen extends StatefulWidget {
  // Props
  BriefScreen({@required this.index});

  final int index;
  @override
  _BriefScreenState createState() => _BriefScreenState();
}

class _BriefScreenState extends State<BriefScreen> {
  void onFabTap(String input) {
    TodoItem item = TodoItemsService.of(context).getTodoItems()[widget.index];
    TodoItemsService.of(context).updateItem(
        widget.index,
        item.title,
        input,
        item.debrief,
        item.dateAdded,
        item.dateCompleted,
        item.priority,
        item.isArchived);
  }

  @override
  Widget build(BuildContext context) {
    return FormPanel(
        handleFab: this.onFabTap, panelLogo: BriefLogo(), panelTitle: "Brief");
  }
}
