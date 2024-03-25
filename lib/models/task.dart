class Task {
  String text;
  bool complete = false;
  DateTime? completeDate;
  DateTime? deadline;

  Task(this.text, [this.deadline]);
}
