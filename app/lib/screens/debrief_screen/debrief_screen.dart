import 'package:flutter/material.dart';
import 'package:todo_list/components/form_panel/form_panel.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/screens/debrief_screen/components/debrief_logo.dart';

/// This screen is where the user can add a [TodoItem.debrief] to the given [TodoItem] at the given [index].
class DebriefScreen extends StatefulWidget {
  // Props
  DebriefScreen({@required this.index});

  final int index;
  @override
  _DebriefScreenState createState() => _DebriefScreenState();
}

class _DebriefScreenState extends State<DebriefScreen> {
  void onFabTap(String input) {
    TodoItem item = TodoItemsService.of(context).getTodoItems()[widget.index];
    TodoItemsService.of(context).updateItem(
        widget.index,
        item.title,
        item.brief,
        input,
        item.dateAdded,
        item.dateCompleted,
        item.priority,
        item.isArchived);
  }

  @override
  Widget build(BuildContext context) {
    return FormPanel(
      handleFab: this.onFabTap,
      panelLogo: DebriefLogo(),
      panelTitle: "Debrief",
    );
  }
}
