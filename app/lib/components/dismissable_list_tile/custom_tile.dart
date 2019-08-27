import 'package:flutter/material.dart';
import 'package:todo_list/components/dismissable_list_tile/abc_priority.dart';
import 'package:todo_list/data/items_injector.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/utils/date_formater.dart';

class CustomTile extends StatelessWidget {
  CustomTile(
      {this.index,
      this.entry,
      this.leadButton,
      this.trailButton,
      this.crossOut,
      this.details,
      this.cardType,
      this.prioritize,
      this.altButton});

  final int index;
  final TodoItem entry;
  final leadButton;
  final trailButton;
  final bool crossOut;
  final String details;
  final String cardType;
  final bool prioritize;
  final IconButton altButton;

  onPriorityChanged(Priorites newPriority, BuildContext context) {
    TodoItemsService.of(context)
        .updatePriority(this.index, this.entry, newPriority);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    DateTime dateAdded = this.entry.dateAdded;
    DateTime dateCompleted = this.entry.dateCompleted;
    final addedMonth = DateFormater().getDateShortMonth(dateAdded);

    final addedDay = dateAdded.day;
    final addedYear = dateAdded.year;

    var completedMonth;
    var completedDay;
    var completedYear;

    if (dateCompleted != null) {
      completedMonth = DateFormater().getDateShortMonth(dateCompleted);
      completedDay = dateCompleted.day;
      completedYear = dateCompleted.year;
    }

    Widget thirdButtonContainer;
    if (this.altButton != null) {
      thirdButtonContainer = Center(
        child: this.altButton,
      );
    } else {
      thirdButtonContainer = Container();
    }

    Card priorityCard;
    if (prioritize != null) {
      priorityCard = (Card(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ABCPriority(
              onChange: onPriorityChanged,
              priority: entry.priority,
            ),
          )));
    } else {
      priorityCard = Card();
    }
    return Card(
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TODO: Use a list tile here instead to have longpress functionality.
            SizedBox(height: 8.0),
            Text(this.entry.title == null ? "" : entry.title,
                style: localTheme.textTheme.headline.copyWith(
                    decoration:
                        this.crossOut ? TextDecoration.lineThrough : null)),
            SizedBox(height: 16.0),
            Text("Start: " + addedMonth + " $addedDay, " + "$addedYear",
                style: localTheme.textTheme.caption),
            SizedBox(height: 16.0),
            Text(
              dateCompleted == null
                  ? "Finished: ... "
                  : "Finished: " +
                      completedMonth +
                      " $completedDay, " +
                      "$completedYear",
              style: localTheme.textTheme.caption,
            ),
            SizedBox(
              height: this.altButton != null ? 16.0 : 0.0,
            ),
            thirdButtonContainer,
            SizedBox(
              height: 8.0,
            )
          ],
        ),
        leading: leadButton,
        trailing: trailButton,
        children: <Widget>[
          SizedBox(height: 16),
          Card(
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  this.cardType,
                  style: TextStyle(fontSize: 20),
                ),
              )),
          SizedBox(height: 16),
          priorityCard,
          SizedBox(height: 8.0),
          Card(
            color: Theme.of(context).accentColor,
            child: SizedBox(
              width: BoxConstraints.expand().maxWidth,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(this.details == "" ? "Add text ..." : this.details,
                    style: localTheme.accentTextTheme.body1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
