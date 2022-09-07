class Task {
  late String taskName;
  DateTime? data;
  bool isStarred;
  bool isCompleted;

  Task(
      {required this.taskName,
      required this.data,
      this.isStarred = false,
      this.isCompleted = false});

  @override
  String toString() => "Student {$taskName, $data, $isStarred, $isCompleted}";
}