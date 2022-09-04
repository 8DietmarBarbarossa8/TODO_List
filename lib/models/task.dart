class Task {
  late String taskName;
  late DateTime data;
  late bool isStarred;
  late bool isCompleted;

  Task(
      {required this.taskName,
      required this.data,
      required this.isStarred,
      required this.isCompleted});
}
