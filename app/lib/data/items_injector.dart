import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/models/todo_item.dart';

enum ItemState { Archived, Unarchived }

/// The Container for [_ItemsInjector] to manage the [State] of this application.
///
/// This [Widget] is our single source of truth in this application.
/// It containes the [TodoItem]s that have been archived in [_mArchives] member
/// variable, and it contains the [TodoItem]s that have not yet been archived in /// [_mTodos] member variable. [_mTodos] and [_mArchives] are the only two
/// state variables that need to be accessible all throughout this application.
/// Hence, having an [InheritedWidget] to help with this process is the
/// route chosen for state management.
class TodoItemsService extends StatefulWidget {
  // This wiget is the root of the tree. Hence it must have a child!
  final Widget child;

  TodoItemsService({@required this.child});

  // This makes accessing todos all over your app possible.
  static _TodoItemsServiceState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_ItemsInjector)
            as _ItemsInjector)
        .data;
  }

  @override
  _TodoItemsServiceState createState() => _TodoItemsServiceState();
}

class _TodoItemsServiceState extends State<TodoItemsService> {
  // Memeber variables.

  // TODO: Remove when done with development.
  bool _dbOFF = false;

  /// [TodoItem]s that have not yet been archived.
  ///
  /// These [TodoItem]s should always be ordered by their [TodoItem.priority]
  /// field.
  List<TodoItem> _mTodos = [];

  /// [TodoItem]s that have been archived.
  ///
  /// These [TodoItem]s should always be ordered by their [TodoItem.priority]
  /// field.
  List<TodoItem> _mArchives = [];

  @override
  void initState() {
    super.initState();

    // if (!this._dbOFF) _updateDB();
    if (!this._dbOFF) _loadItemsFromDB();
  }

  /// Load all items saved in [SQLiteDatabase].
  ///
  /// For unarchived [TodoItem]s cache items in [_mTodos], and for archived
  /// [TodoItem]s cache items in [_mArchives].
  Future<void> _loadItemsFromDB() async {
    print("Loading item from db ...");
    SQLiteDatabase sDB = SQLiteDatabase.db;
    // sDB.updateDB();
    List<TodoItem> unarchivedItems = await sDB.getUnarchivedItemsByPriority();
    if (unarchivedItems != null) {
      this.setState(() {
        _mTodos = unarchivedItems;
      });
    }
    List<TodoItem> archivedItems = await sDB.getArchivedItemsByPriority();
    if (archivedItems != null) {
      this.setState(() {
        _mArchives = archivedItems;
      });
    }

    for (TodoItem item in unarchivedItems) {
      print("item injector: unarchive item title = ${item.title}");
    }

    for (TodoItem item in archivedItems) {
      print("item injector: archive item title = ${item.title}");
    }
  }

  /// Update items in [SQLiteDatabase] with new updated [TodoItem].
  // TODO: Remove after development.
  Future<void> _updateDB() async {
    print("Updating db ...");
    SQLiteDatabase sDB = SQLiteDatabase.db;
    List<TodoItem> items = await sDB.items();
    List<TodoItem> updates = [];
    for (TodoItem item in items) {
      TodoItem updated = TodoItem(
          id: item.id,
          title: item.title,
          brief: item.brief,
          debrief: item.debrief,
          dateAdded: item.dateAdded,
          dateCompleted: item.dateCompleted,
          priority: Priorites.A,
          isArchived: 0);
      sDB.updateItem(updated);
    }
  }

  /// Get all [TodoItem]s saved in this state that have not yet been archived.
  List<TodoItem> getTodoItems() {
    return _mTodos;
  }

  /// Get all [TodoItem]s saved in this state that have been archived.
  List<TodoItem> getArchivedItems() {
    return _mArchives;
  }

  /// Move [item] to [_mArchives] and change [item.archives] to 1.
  ///
  /// In the [SQLiteDatabase] 1 represents an archived [TodoItem] and
  /// 0 represents an unarchived [TodoItem] for the is_archived field.
  /// The move should conserve the order of [Priorities] in [_mArchives].
  void moveToArchives(int index, TodoItem item) {
    // Remove [item] from [_mTodos].
    this.setState(() {
      _mTodos.removeAt(index);
    });

    // Update archive status of [item] in database.
    TodoItem updated = this.updateIsArchived(item, 1);

    // Insert [item] with priority in [_mArchives].
    this.insertItemWithPriority(updated, ItemState.Archived);
  }

  /// Move [item] to [_mTodos] and change [item.archives] to 0.
  ///
  /// In the [SQLiteDatabase] 1 represents an archived [TodoItem] and
  /// 0 represents an unarchived [TodoItem] for the is_archived field.
  /// The move should conserve the order of [Priorities] in  [_mArchives].
  void moveToTodos(int index, TodoItem item) {
    // Remove [item] from [_mArchives].
    this.setState(() {
      _mArchives.removeAt(index);
    });

    // Update archive status of [item] in database.
    TodoItem updated = this.updateIsArchived(item, 0);

    // Insert [item] with priority in [_mTodos].
    this.insertItemWithPriority(updated, ItemState.Unarchived);
  }

  /// Filter out all [TodoItem]s that have been completed, and return
  /// a [List] of [TodoItem]s containing these items.
  List<TodoItem> getDoneItems() {
    List<TodoItem> dones = [];
    for (int i = 0; i < _mTodos.length; i++) {
      if (_mTodos[i].dateCompleted != null) {
        dones.add(_mTodos[i]);
      }
    }
    return dones;
  }

  /// Insert [TodoItem] into [_mTdos] at index [index].
  void _insertUnarchivedItem(int index, TodoItem item) {
    this.setState(() {
      _mTodos.insert(index, item);
    });
  }

  /// Insert [TodoItem] into [_mArchives] at index [index].
  void _insertArchivedItem(int index, TodoItem item) {
    this.setState(() {
      _mArchives.insert(index, item);
    });
  }

  /// Remove [TodoItem] at index [index] from [_mTodos],
  /// and from the [SQLiteDatabase].
  void removeUnarchivedItemAt(int index) {
    // Get id of item at [index].
    String itemId = _mTodos[index].id;
    // Update state: remove from state.
    this.setState(() {
      _mTodos.removeAt(index);
    });

    // Update database: remove from db.
    if (!this._dbOFF) SQLiteDatabase.db.deleteItem(itemId);
  }

  /// Remove [TodoItem] at index [index] from [_mArchives],
  /// and from the [SQLiteDatabase].
  void removeArchivedItemAt(int index) {
    // Get id of item at [index].
    String itemId = _mArchives[index].id;
    // Update state: remove from state.
    this.setState(() {
      _mArchives.removeAt(index);
    });

    // Update database: remove from db.
    if (!this._dbOFF) SQLiteDatabase.db.deleteItem(itemId);
  }

  /// Update [item]'s priority in [_mTodos] and update database.
  void updatePriority(int index, TodoItem item, Priorites newPriority) {
    print("updatePriority: updating ...");

    this.setState(() {
      _mTodos.removeAt(index);
    });

    TodoItem updated = TodoItem(
        id: item.id,
        title: item.title,
        brief: item.brief,
        debrief: item.debrief,
        dateAdded: item.dateAdded,
        dateCompleted: item.dateCompleted,
        priority: newPriority,
        isArchived: item.isArchived);

    int indexFound = _binarySearchItemWithPriority(updated, _mTodos);
    print("updatePriority: indexFound = $indexFound");
    if (indexFound < 0) indexFound = ~indexFound;
    print("updatePriority: indexFound = $indexFound after tilde check");

    // Update state: insert new updated item with respect to priority and remove
    // prev item in list.

    this.setState(() {
      _mTodos.insert(indexFound, updated);
    });

    // Update database: update item in db with id [updated.id]
    if (!this._dbOFF) SQLiteDatabase.db.updateItem(updated);
  }

  /// Insert [item] in either [_mArchives] or [_mTodos] given [state] value with respect to [TodoItem.priority] field.
  ///
  /// [state] takes in only two values: [ItemState.Archived] or [ItemState.Unarchived].
  void insertItemWithPriority(TodoItem item, ItemState state) {
    if (state == ItemState.Archived) {
      int indexFound = _binarySearchItemWithPriority(item, _mArchives);
      // Update state: insert new item at[indexFound] in [_mArchives].
      if (indexFound < 0) indexFound = ~indexFound;
      this._insertArchivedItem(indexFound, item);
    } else {
      int indexFound = _binarySearchItemWithPriority(item, _mTodos);
      // Update state: insert new item at [indexFound] in [_mTodos].
      if (indexFound < 0) indexFound = ~indexFound;
      this._insertUnarchivedItem(indexFound, item);
    }

    // Update database: update item in db with id [updated.id].
    if (!this._dbOFF) SQLiteDatabase.db.insertItem(item);
  }

  /// Find correct position that [item] should be inserted into [list] with
  /// respect to the [Priorities] field.
  ///
  /// Uses a modified version of the binarySearchAlgorithm to find index more
  /// efficiently.
  int _binarySearchItemWithPriority(TodoItem item, List<TodoItem> list) {
    return _binarySearchItemWithPriorityHelper(item, list, 0, list.length - 1);
  }

  /// Helper function: look at [_binarySearchItemWithPriorities()] for details.
  ///
  /// Recursive helper function that is given a [left] parameter
  /// and [right] parameter so it can recursively find the correct position of
  /// [item] with respect to the [Priorities] field in the already sorted [list]
  /// list.
  int _binarySearchItemWithPriorityHelper(
      TodoItem item, List<TodoItem> list, int left, int right) {
    String alphaPrior;

    print(
        "_binarySearchUnarchivedItemWithPriorityHelper: left = $left; right = $right");

    switch (item.priority) {
      case Priorites.B:
        alphaPrior = "B";
        break;
      case Priorites.C:
        alphaPrior = "C";
        break;
      case Priorites.D:
        alphaPrior = "D";
        break;
      case Priorites.E:
        alphaPrior = "E";
        break;
      default:
        alphaPrior = "A";
    }

    // * Base case check.
    if (right >= left) {
      int mid = left + (right - left) ~/ 2;
      String alphaMid;
      switch (list[mid].priority) {
        case Priorites.B:
          alphaMid = "B";
          break;
        case Priorites.C:
          alphaMid = "C";
          break;
        case Priorites.D:
          alphaMid = "D";
          break;
        case Priorites.E:
          alphaMid = "E";
          break;
        default:
          alphaMid = "A";
      }
      print("_binarySearchUnarchivedItemWithPriorityHelper: mid = $mid");
      if (alphaPrior == alphaMid || (alphaPrior != alphaMid && left == right)) {
        return mid + 1;
      } else if (alphaPrior.compareTo(alphaMid) > 0) {
        // alphaPrior comes after alphaMid, hence
        // alphaPrior has lower priority than alphaPriorMid.
        // Check right side of mid point.
        return _binarySearchItemWithPriorityHelper(item, list, mid + 1, right);
      } else {
        // alphaPrior comes before alphaPriorMid, hence
        // alphaPrior has higher priority than alphaPriorMid.
        // Check left side of mid point.
        print(
            "_binarySearchUnarchivedItemWithPriorityHelper: item at left side of mid = $mid");
        return _binarySearchItemWithPriorityHelper(item, list, left, mid - 1);
      }
    } else {
      print("_binarySearchUnarchivedItemWithPriorityHelper: retunring -1!");
      print(
          "_binarySearchUnarchivedItemWithPriorityHelper: left = $left; right = $right");

      return -1;
    }
  }

  /// Update archived status of [item] in [SQLiteDatabase] with [newIsArchived] value.
  ///
  /// No state changes should be done here since by changing the archived status
  /// [item] has to be moved from one list to the other.
  ///
  /// Returnes the updated version of [item].
  TodoItem updateIsArchived(TodoItem item, int newIsArchived) {
    TodoItem updated = TodoItem(
        id: item.id,
        title: item.title,
        brief: item.brief,
        debrief: item.debrief,
        dateAdded: item.dateAdded,
        dateCompleted: item.dateCompleted,
        priority: item.priority,
        isArchived: newIsArchived);

    // Update database: update item in db with id [updated.id]
    if (!this._dbOFF) SQLiteDatabase.db.updateItem(updated);
    return updated;
  }

  /// Update item at index [index] by replacing item with new given data.
  ///
  /// [TodoItem]s can only be freely updated when they are not archived.
  void updateItem(int index, String text, String brief, String debrief,
      DateTime added, DateTime completed, Priorites priority, int archived) {
    TodoItem prev = this._mTodos[index];

    TodoItem updated = TodoItem(
        id: prev.id,
        title: text,
        brief: brief,
        debrief: debrief,
        dateAdded: added,
        dateCompleted: completed,
        priority: priority,
        isArchived: archived);

    // Update state: update item at [index] in state.
    this.setState(() {
      _mTodos.replaceRange(index, index + 1, [updated]);
    });

    // Update database: update item in db with id [updated.id].
    if (!this._dbOFF) SQLiteDatabase.db.updateItem(updated);
  }

  @override
  Widget build(BuildContext context) {
    return _ItemsInjector(child: widget.child, data: this);
  }
}

class _ItemsInjector extends InheritedWidget {
  final _TodoItemsServiceState data;

  _ItemsInjector({@required this.data, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static _ItemsInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(_ItemsInjector);
}
