import 'package:flutter/material.dart';
import 'package:todo_list/components/dismissable_list_tile/dismissable_list_tile.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/screens/debrief_screen/debrief_screen.dart';

class DoneScreen extends StatefulWidget {
  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  // ! TODO: fix bug when changing priority.
  void onTrailTap(int index) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DebriefScreen(index: index)));
  }

  Widget _buildTile(index, TodoItem item) {
    Icon trailIcon = Icon(Icons.keyboard_arrow_right);
    IconButton trailButton = IconButton(
      icon: trailIcon,
      onPressed: () => this.onTrailTap(index),
    );
    return DismissibleListTile(
      index: index,
      entry: item,
      cardType: "Debrief",
      details: item.debrief,
      trailButton: trailButton,
      crossOut: false,
    );

    // return DoneListTile(entry: item, index: index);
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> dones = TodoItemsService.of(context).getDoneItems();
    List<TodoItem> items = TodoItemsService.of(context).getTodoItems();
    ThemeData localTheme = Theme.of(context);

    Widget content;

    if (dones.length == 0) {
      content = Center(
        child: Text(
          "No items have been completed!",
          style: localTheme.textTheme.body1,
        ),
      );
    } else {
      content = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (items[index].dateCompleted != null) {
            return Padding(
                key: ValueKey(items[index].id),
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                child: _buildTile(index, items[index]));
          } else
            return Container();
        },
      );
    }

    return Container(child: content);
  }
}
