import 'dart:collection';
import 'package:flutter/material.dart';
import 'task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String taskTitle) {
    _tasks.add(Task(name: taskTitle));
    saveTasks();
    notifyListeners();
  }

  void renameTask(int index, String newName) {
    tasks[index].name = newName;
    saveTasks();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateTask(Task task) {
    task.toggleDone();
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void _initialize() async {
    await _loadTasks(); // Now we can use await here
    notifyListeners(); // Update the UI after loading
  }

  TaskData() {
    _initialize(); // Load saved tasks when the provider initializes
  }
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> tasksJson = jsonDecode(tasksString);
      _tasks = tasksJson.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString =
        jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksString);
  }
}
