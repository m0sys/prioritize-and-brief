import 'package:flutter/material.dart';
import 'package:todo_list/components/accent_color_override/accent_color_override.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:uuid/uuid.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  // Private member variables
  String _mInputText;
  // List<TodoListTile> _mItems;

  // Create textfield controller
  TextEditingController _mTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mInputText = "";
    _mTextController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _mTextController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    this.setState(() {
      _mInputText = _mTextController.text;
    });
  }

  void handleValidInput() {
    var uuid = Uuid();

    DateTime now = DateTime.now();
    print("Add button pressed!");
    print("creating new item! now is $now \n\n\n");
    TodoItem newItem = TodoItem(
        id: uuid.v1(),
        title: _mInputText,
        brief: "",
        debrief: "",
        dateAdded: now,
        dateCompleted: null,
        priority: Priorites.A,
        isArchived: 0);
    // TodoItemsService.of(context).addItem(newItem);
    TodoItemsService.of(context).insertUnarchivedItemWithPriority(newItem);
    this.setState(() {
      _mInputText = "";
    });
    _mTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: AccentColorOverride(
            color: localTheme.accentColor,
            child: TextFormField(
              controller: _mTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "todo",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                  this.handleValidInput();
                } else {
                  print("todo screen: text control has not text!");
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please type a new todo ..."),
                  ));
                }
              },
              child: Text(
                'Add',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
