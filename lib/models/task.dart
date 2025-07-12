class Task {
  String name;
  bool isDone;
  Task({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'isDone': isDone};
  }

  // Convert JSON to Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(name: json['name'], isDone: json['isDone']);
  }
}
