import 'package:flutter/material.dart';
import 'package:todo_list/components/dismissable_list_tile/dismissable_list_tile.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/screens/brief_screen/brief_screen.dart';
import 'package:todo_list/screens/todo/components/custom_pop_menu/custom_popup_menu.dart';
import 'package:todo_list/screens/todo/components/form/add_form.dart';

// Data import
import '../../data/items_injector.dart';

// Import components
import "../../models/todo_item.dart";

/// This screen is where the user can view and add unarchived [TodoItem]s.
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void onToggle(int index, TodoItem item) {
    if (item.dateCompleted == null) {
      DateTime now = DateTime.now();
      TodoItemsService.of(context).updateItem(index, item.title, item.brief,
          item.debrief, item.dateAdded, now, item.priority, item.isArchived);
    } else {
      TodoItemsService.of(context).updateItem(index, item.title, item.brief,
          item.debrief, item.dateAdded, null, item.priority, item.isArchived);
    }
  }

  void onDismiss(int index) {
    TodoItemsService.of(context).removeUnarchivedItemAt(index);
  }

  void onTrailTap(int index) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BriefScreen(index: index)));
  }

  void onArchive(int index, TodoItem item) {
    TodoItemsService.of(context).moveToArchives(index, item);
  }

  Widget _buildTile(int index, TodoItem item) {
    Icon leadIcon = Icon(item.dateCompleted != null
        ? Icons.check_box
        : Icons.check_box_outline_blank);
    // Icon trailIcon = Icon(Icons.keyboard_arrow_right);
    CustomPopupMenu trailButton = CustomPopupMenu(
      entry: item,
      index: index,
      onArchive: this.onArchive,
      onBrief: this.onTrailTap,
    );

    // Icon altIcon = Icon(item.isArchived == 1 ? Icons.unarchive : Icons.archive);

    IconButton leadButton =
        IconButton(icon: leadIcon, onPressed: () => this.onToggle(index, item));
    bool crossMe = item.dateCompleted != null ? true : false;
    return DismissibleListTile(
      index: index,
      entry: item,
      cardType: "Brief",
      details: item.brief,
      trailButton: trailButton,
      leadButton: leadButton,
      crossOut: crossMe,
      isDismissible: true,
      prioritize: true,
      onDismiss: this.onDismiss,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    List<TodoItem> todos = TodoItemsService.of(context).getTodoItems();
    Widget content;
    if (todos.length != 0) {
      content = Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              key: ValueKey(todos[index].id),
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: _buildTile(index, todos[index]));
        },
      ));
    } else {
      content = Center(
        child: Text(
          "Please add a new task!",
          style: localTheme.textTheme.body1,
        ),
      );
    }
    return (Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        content,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: AddForm(),
        ),
      ],
    )));
  }
}
