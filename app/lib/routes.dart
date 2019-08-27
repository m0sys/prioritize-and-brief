import 'package:flutter/material.dart';
import 'package:todo_list/screens/archived_screen/archived_screen.dart';
import 'package:todo_list/screens/settings_screen/settings_screen.dart';

// Import all screens in this file.
import './screens/todo/todo_screen.dart';
import './screens/done/done_screen.dart';

enum AppBarMenuOptions { Archived, Settings }

class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> with SingleTickerProviderStateMixin {
  // Private memeber variables.
  TabController _mController;
  AppBarMenuOptions _mSelectedOption;
  // List<TodoItem> _mTodoItems;

  @override
  void initState() {
    super.initState();
    _mController = TabController(length: 2, vsync: this);
    // _mTodoItems = [];
  }

  @override
  void dispose() {
    _mController.dispose();
    // _mTodoItems.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('TODO'),
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.check_box_outline_blank),
            ),
            Tab(icon: Icon(Icons.check_box)),
          ],
          controller: _mController,
        ),
        actions: <Widget>[
          PopupMenuButton<AppBarMenuOptions>(
            onSelected: (AppBarMenuOptions result) {
              this.setState(() {
                _mSelectedOption = result;
              });
              switch (this._mSelectedOption) {
                case AppBarMenuOptions.Archived:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArchivedScreen()));
                  break;
                default:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
              }
            },
            icon: Icon(Icons.more_vert),
            tooltip: 'Archive item',
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<AppBarMenuOptions>>[
              const PopupMenuItem<AppBarMenuOptions>(
                child: Text("Archive"),
                value: AppBarMenuOptions.Archived,
              ),
              const PopupMenuItem<AppBarMenuOptions>(
                child: Text("Settings"),
                value: AppBarMenuOptions.Settings,
              ),
            ],
          )
        ],
      ),
      body: TabBarView(
          children: <Widget>[TodoScreen(), DoneScreen()],
          controller: _mController),
    ));
  }
}
