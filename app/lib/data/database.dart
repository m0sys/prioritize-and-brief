import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:todo_list/models/todo_item.dart';

/// Main application database writen in sqlite.
class SQLiteDatabase {
  SQLiteDatabase._();
  static final SQLiteDatabase db = SQLiteDatabase._();

  // temp flags to clear out when shipped
  bool runUpdates = true;

  /// Create database object
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  /// Initialize and retrieve a reference to the database
  /// for this application.
  initDB() async {
    print("initDB: start ...");
    var databasePath = await getDatabasesPath();
    // Create the path to the database
    String path = join(databasePath, 'prioritize_todo_list.db');
    return await openDatabase(path,
        // When the database is first initalized, create a table of todo items
        onCreate: (db, version) {
      print("initDB: onCreate called!");
      return db.execute(
          "CREATE TABLE todo_items(id TEXT PRIMARY KEY, title TEXT, brief TEXT, debrief TEXT, date_added INTEGER, date_completed INTEGER, priority TEXT, is_archived INTEGER)");
    },
        // Set the version. This executes the onCreate function and provides a path to
        // perform database upgrades and downgrades.
        version: 1);
  }

  // @(temp method: hack to not lose data)
  // Update the database with what ever you like. The power is yours
  updateDB() async {
    // Get a reference to the database
    Database db = await database;
    print("updateDB: updating database!");
    db.execute("ALTER TABLE todo_items ADD COLUMN is_archived INTEGER");
    print("udateDB: added column!");
    print("updateDB: done!");
  }

  /// Inserts todo items into this [_database].
  Future<void> insertItem(TodoItem item) async {
    print("Inserting item into database!");

    // Get a reference to the database
    Database db = await database;

    // Insert the TodoItem into the correct table.
    // Note: You might also specify the 'conflictAlgorithm' to
    // use in case the same dog is inserted twice.

    // TODO: For now, reaplce any previous data

    await db.insert('todo_items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Retrive all the [TodoItem]s from the todo_items
  /// table.
  Future<List<TodoItem>> items() async {
    // Get a reference to the database
    Database db = await database;

    // Query the table for all the TodoItems
    final List<Map<String, dynamic>> maps = await db.query('todo_items');

    // Convert the List<Map<String, dynamic>> into a List<TodoItems>
    return List.generate(maps.length, (i) {
      Priorites priority;

      switch (maps[i]['priority']) {
        case 'B':
          priority = Priorites.B;
          break;
        case 'C':
          priority = Priorites.C;
          break;
        case 'D':
          priority = Priorites.D;
          break;
        case 'E':
          priority = Priorites.E;
          break;
        default:
          priority = Priorites.A;
      }

      return TodoItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          brief: maps[i]['brief'],
          debrief: maps[i]['debrief'],
          dateAdded: maps[i]['date_added'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_added'])
              : maps[i]['date_added'],
          dateCompleted: maps[i]['date_completed'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_completed'])
              : maps[i]['date_completed'],
          priority: priority,
          isArchived: maps[i]['is_archived']);
    });
  }

  /// Update [item] with id [item.id] in the database with the new values in
  /// [item].
  Future<void> updateItem(TodoItem item) async {
    print("updating database!");
    print("item id = ${item.id}");
    // Get a reference to the database
    Database db = await database;
    // Update the given TodoItem
    await db.update(
      'todo_items',
      item.toMap(),
      // Ensure the the TodoItem has a matching id ...
      where: "id = ?",
      // Pass the TodoItem's id as a whereArg to preent SQL injection
      whereArgs: [item.id],
    );
  }

  /// Delete item with id [id] from this [_database].
  Future<void> deleteItem(String id) async {
    // Get a reference to the database
    Database db = await database;

    // Remove the TodoItem with <id> from the database
    await db.delete(
      'todo_items',
      // User a 'where' clause to delete a specific item
      where: "id = ?",
      // Pass the TodoItem's id as a where to prevent SQL injection
      whereArgs: [id],
    );
  }

  /// Order all items in [_database] with respect to their [Priorites].
  ///
  /// Returns a [Future] containing all [TodoItem]s in the [_database].
  Future<List<TodoItem>> orderByPriority() async {
    // Get a reference to the database
    Database db = await database;
    /*
    final List<Map<String, dynamic>> maps =
        await db.query('todo_items', orderBy: 'title');
        */
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM todo_items ORDER BY priority, title, date_added');

    // Convert the List<Map<String, dynamic>> into a List<TodoItems>
    return List.generate(maps.length, (i) {
      Priorites priority;

      switch (maps[i]['priority']) {
        case 'B':
          priority = Priorites.B;
          break;
        case 'C':
          priority = Priorites.C;
          break;
        case 'D':
          priority = Priorites.D;
          break;
        case 'E':
          priority = Priorites.E;
          break;
        default:
          priority = Priorites.A;
      }

      return TodoItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          brief: maps[i]['brief'],
          debrief: maps[i]['debrief'],
          dateAdded: maps[i]['date_added'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_added'])
              : maps[i]['date_added'],
          dateCompleted: maps[i]['date_completed'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_completed'])
              : maps[i]['date_completed'],
          priority: priority,
          isArchived: maps[i]['is_archived']);
    });
  }

  /// Get all unarchived [TodoItem]s in this [_database] ordered by [Priorites].
  Future<List<TodoItem>> getUnarchivedItemsByPriority() async {
    // Get a reference to the database
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM todo_items WHERE is_archived = 0 ORDER BY priority, title, date_added ');
    return List.generate(maps.length, (i) {
      Priorites priority;

      switch (maps[i]['priority']) {
        case 'B':
          priority = Priorites.B;
          break;
        case 'C':
          priority = Priorites.C;
          break;
        case 'D':
          priority = Priorites.D;
          break;
        case 'E':
          priority = Priorites.E;
          break;
        default:
          priority = Priorites.A;
      }

      return TodoItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          brief: maps[i]['brief'],
          debrief: maps[i]['debrief'],
          dateAdded: maps[i]['date_added'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_added'])
              : maps[i]['date_added'],
          dateCompleted: maps[i]['date_completed'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_completed'])
              : maps[i]['date_completed'],
          priority: priority,
          isArchived: maps[i]['is_archived']);
    });
  }

  /// Get all archived [TodoItem] in this [_database] ordered by [Priorities].
  Future<List<TodoItem>> getArchivedItemsByPriority() async {
    // Get a reference to the database
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM todo_items WHERE is_archived = 1 ORDER BY priority, title, date_added');

    // Convert the List<Map<String, dynamic>> into a List<TodoItems>
    return List.generate(maps.length, (i) {
      Priorites priority;

      switch (maps[i]['priority']) {
        case 'B':
          priority = Priorites.B;
          break;
        case 'C':
          priority = Priorites.C;
          break;
        case 'D':
          priority = Priorites.D;
          break;
        case 'E':
          priority = Priorites.E;
          break;
        default:
          priority = Priorites.A;
      }

      return TodoItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          brief: maps[i]['brief'],
          debrief: maps[i]['debrief'],
          dateAdded: maps[i]['date_added'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_added'])
              : maps[i]['date_added'],
          dateCompleted: maps[i]['date_completed'] != null
              ? DateTime.fromMillisecondsSinceEpoch(maps[i]['date_completed'])
              : maps[i]['date_completed'],
          priority: priority,
          isArchived: maps[i]['is_archived']);
    });
  }
}
