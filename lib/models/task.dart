const String tableTasks = 'tasks';

class TaskFields {
  static const String id = 'id';
  static const String taskName = 'taskName';
  static const String data = "data";
  static const String isStarred = 'isStarred';
  static const String isCompleted = 'isCompleted';
}

class Task {
  final int? id;
  late String taskName;
  DateTime data;
  bool isStarred;
  bool isCompleted;

  Task(
      {this.id,
      required this.taskName,
      required this.data,
      this.isStarred = false,
      this.isCompleted = false});

  @override
  String toString() => "Student {$taskName, $data, $isStarred, $isCompleted}";

  Map<String, dynamic> toMap() => {
        TaskFields.id: id,
        TaskFields.taskName: taskName,
        TaskFields.data: data.toString(),
        TaskFields.isStarred: isStarred ? 1 : 0,
        TaskFields.isCompleted: isCompleted ? 1 : 0,
      };
}
