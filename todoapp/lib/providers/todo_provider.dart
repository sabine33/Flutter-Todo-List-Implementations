import 'dart:collection';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_service.dart';

class TodoListProvider extends ChangeNotifier {
  final List<TodoItem> _tasks = StorageService.getTodos();

  List<TodoItem> get tasks => UnmodifiableListView(_tasks);

  addTodo(String title) {
    _tasks.add(TodoItem(title: title, isCompleted: false));
    print(jsonEncode(_tasks));
    StorageService.saveTodos(_tasks);

    notifyListeners();
  }

  clearAll() {
    _tasks.clear();
    StorageService.saveTodos(_tasks);
    notifyListeners();
  }

  removeTodo(TodoItem item) {
    _tasks.removeAt(_tasks.indexOf(item));
    StorageService.saveTodos(_tasks);

    notifyListeners();
  }

  updateTodo(TodoItem todoItem, String newTitle) {
    var index = _tasks.indexOf(todoItem);
    _tasks[index].title = newTitle;
    StorageService.saveTodos(_tasks);
    notifyListeners();
  }

  toggleCompletion(TodoItem item) {
    var index = _tasks.indexOf(item);
    _tasks[index].toggle();
    StorageService.saveTodos(_tasks);
    notifyListeners();
  }
}
