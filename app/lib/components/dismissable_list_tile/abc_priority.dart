import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';

class ABCPriority extends StatefulWidget {
  ABCPriority({this.onChange, this.priority});

  final Function onChange;
  final Priorites priority;
  @override
  _ABCPriorityState createState() => _ABCPriorityState();
}

class _ABCPriorityState extends State<ABCPriority> {
  // Memeber variables
  Priorites _mChar;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      _mChar = widget.priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Radio(
              activeColor: localTheme.accentColor,
              groupValue: _mChar,
              onChanged: (Priorites value) {
                this.setState(() {
                  _mChar = value;
                });
                widget.onChange(_mChar, context);
              },
              value: Priorites.A,
            ),
            Radio(
              activeColor: localTheme.accentColor,
              groupValue: _mChar,
              onChanged: (Priorites value) {
                this.setState(() {
                  _mChar = value;
                });
                widget.onChange(_mChar, context);
              },
              value: Priorites.B,
            ),
            Radio(
              activeColor: localTheme.accentColor,
              groupValue: _mChar,
              onChanged: (Priorites value) {
                this.setState(() {
                  _mChar = value;
                });
                widget.onChange(_mChar, context);
              },
              value: Priorites.C,
            ),
            Radio(
              activeColor: localTheme.accentColor,
              groupValue: _mChar,
              onChanged: (Priorites value) {
                this.setState(() {
                  _mChar = value;
                });
                widget.onChange(_mChar, context);
              },
              value: Priorites.D,
            ),
            Radio(
              activeColor: localTheme.accentColor,
              groupValue: _mChar,
              onChanged: (Priorites value) {
                this.setState(() {
                  _mChar = value;
                });
                widget.onChange(_mChar, context);
              },
              value: Priorites.E,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'A',
              style: localTheme.textTheme.caption,
            ),
            Text(
              'B',
              style: localTheme.textTheme.caption,
            ),
            Text(
              'C',
              style: localTheme.textTheme.caption,
            ),
            Text(
              'D',
              style: localTheme.textTheme.caption,
            ),
            Text(
              'E',
              style: localTheme.textTheme.caption,
            ),
          ],
        )
      ],
    );
  }
}
