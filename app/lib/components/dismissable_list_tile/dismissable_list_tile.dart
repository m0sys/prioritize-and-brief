import 'package:flutter/material.dart';
import 'package:todo_list/components/dismissable_list_tile/custom_tile.dart';
import 'package:todo_list/models/todo_item.dart';

class DismissibleListTile extends StatefulWidget {
  DismissibleListTile({
    @required this.index,
    @required this.entry,
    @required this.cardType,
    this.leadButton,
    this.trailButton,
    this.altButton,
    this.details,
    this.crossOut,
    this.isDismissible,
    this.prioritize,
    this.onDismiss,
  });
  final int index;
  final TodoItem entry;
  final String cardType;
  final String details;
  final leadButton;
  final trailButton;
  final altButton;
  final bool crossOut;
  final bool isDismissible;
  final bool prioritize;
  final Function onDismiss;

  @override
  _DismissibleListTileState createState() => _DismissibleListTileState();
}

class _DismissibleListTileState extends State<DismissibleListTile> {
  // TODO: Add removal animation when reprioritzing items.
  Future<bool> _popupDialog() async {
    ThemeData localTheme = Theme.of(context);
    return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Remove item?"),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text("This item will be removed from your todo list."),
              ],
            )),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Yes".toUpperCase(),
                  style: localTheme.accentTextTheme.button
                      .copyWith(color: localTheme.accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text(
                  "Cancel".toUpperCase(),
                  style: localTheme.accentTextTheme.button
                      .copyWith(color: localTheme.accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.trailIcon != null) {
    //   trailButton = IconButton(
    //       icon: widget.trailIcon,
    //       onPressed: () => widget.trailAction(widget.index));
    // }

    // if (widget.leadIcon != null) {
    //   leadButton = IconButton(
    //       icon: widget.leadIcon,
    //       onPressed: () => widget.leadAction(widget.index, widget.entry));
    // }

    // if (widget.altIcon != null) {
    //   altButton = IconButton(
    //     icon: widget.altIcon,
    //     onPressed: () => widget.onAltAction(widget.index, widget.entry),
    //   );
    // }

    // Dismissble should use the same child element design for both dismissble
    // and non dismissble.
    if (widget.isDismissible != null) {
      return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).errorColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          confirmDismiss: (direction) => _popupDialog(),
          key: ValueKey(widget.entry.id),
          onDismissed: (direction) => widget.onDismiss(widget.index),
          child: CustomTile(
            index: widget.index,
            entry: widget.entry,
            leadButton: widget.leadButton,
            trailButton: widget.trailButton,
            crossOut: widget.crossOut,
            details: widget.details,
            cardType: widget.cardType,
            prioritize: widget.prioritize,
          ));
    } else {
      return CustomTile(
        entry: widget.entry,
        leadButton: widget.leadButton,
        trailButton: widget.trailButton,
        crossOut: widget.crossOut,
        details: widget.details,
        cardType: widget.cardType,
        altButton: widget.altButton,
      );
    }
  }
}
