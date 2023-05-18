class Task {
  String id;
  String name;
  bool isDone;

  Task({required this.id, required this.name, this.isDone = false});

  void doneChange() {
    isDone = !isDone;
  }
}