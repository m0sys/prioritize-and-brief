import 'package:flutter/material.dart';
import 'package:todo_list/components/dismissable_list_tile/dismissable_list_tile.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';

/// This screen is where the user can view archived [TodoItem]s.
class ArchivedScreen extends StatefulWidget {
  @override
  _ArchivedScreenState createState() => _ArchivedScreenState();
}

class _ArchivedScreenState extends State<ArchivedScreen> {
  /// Dismiss [TodoItem] at [index] when user has confirmed dismissal.
  ///
  /// Swipe left to delete [TodoItem] at [index] from [SQLiteDatabase].
  void onDismiss(int index) {
    TodoItemsService.of(context).removeArchivedItemAt(index);
  }

  /// On tap archive button.
  void onUnarchive(int index, TodoItem item) {
    TodoItemsService.of(context).moveToTodos(index, item);
  }

  Widget _buildTile(int index, TodoItem item) {
    IconButton trailButton = IconButton(
      icon: Icon(Icons.unarchive),
      onPressed: () => this.onUnarchive(index, item),
    );
    return DismissibleListTile(
      trailButton: trailButton,
      index: index,
      entry: item,
      cardType: "Brief",
      details: item.brief,
      crossOut: false,
      isDismissible: true,
      onDismiss: this.onDismiss,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> archives = TodoItemsService.of(context).getArchivedItems();

    ThemeData localTheme = Theme.of(context);

    Widget content;

    if (archives.length == 0) {
      content = Center(
        child: Text(
          "No items have been archived!",
          style: localTheme.textTheme.body1,
        ),
      );
    } else {
      content = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: archives.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            key: ValueKey(archives[index].id),
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: _buildTile(index, archives[index]),
          );
        },
      );
    }

    return (Scaffold(
      appBar: AppBar(
        title: Text(
          "Archived",
        ),
      ),
      body: Container(child: content),
    ));
  }
}
