enum Priorites { A, B, C, D, E }

/// Model for todo items.
class TodoItem {
  final String id;
  final String title;
  final String brief;
  final String debrief;
  final DateTime dateAdded;
  final DateTime dateCompleted;
  final Priorites priority;
  final int isArchived;

  const TodoItem(
      {this.id,
      this.title,
      this.brief,
      this.debrief,
      this.dateAdded,
      this.dateCompleted,
      this.priority,
      this.isArchived});

  // Convert a TodoItem into a Map. The keys must correspond
  // to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    String mapPriority;

    switch (priority) {
      case Priorites.B:
        mapPriority = 'B';
        break;
      case Priorites.C:
        mapPriority = 'C';
        break;
      case Priorites.D:
        mapPriority = 'D';
        break;
      case Priorites.E:
        mapPriority = 'E';
        break;
      default:
        mapPriority = 'A';
    }

    return {
      'id': id,
      'title': title,
      'brief': brief,
      'debrief': debrief,
      'date_added':
          dateAdded != null ? dateAdded.millisecondsSinceEpoch : dateAdded,
      'date_completed': dateCompleted != null
          ? dateCompleted.millisecondsSinceEpoch
          : dateCompleted,
      'priority': mapPriority,
      'is_archived': isArchived
    };
  }
}
