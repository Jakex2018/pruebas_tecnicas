import 'package:flutter/material.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListProvider extends ChangeNotifier {
  List<Task> tasks = [];

  TodoListProvider() {
    loadTasks();
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      tasks = taskStrings.map((t) => Task.fromJson(t)).toList();
    }
    notifyListeners();
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  void completeTask(Task task) {
    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
    saveTasks();
    notifyListeners();
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = tasks.map((t) => t.toJson()).toList();
    await prefs.setStringList('tasks', taskStrings);
  }
}
