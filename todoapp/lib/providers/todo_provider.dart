import 'dart:collection';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_service.dart';

class TodoListProvider extends ChangeNotifier {
  late StorageService _storageService;
  late List<TodoItem> _tasks;

  TodoListProvider(StorageService service) {
    _storageService = service;
    _tasks = _storageService.getTodos();
  }

  List<TodoItem> get tasks => UnmodifiableListView(_tasks);

  addTodo(String title) {
    _tasks.add(TodoItem(title: title, isCompleted: false));
    print(jsonEncode(_tasks));
    _storageService.saveTodos(_tasks);

    notifyListeners();
  }

  clearAll() {
    _tasks.clear();
    _storageService.saveTodos(_tasks);
    notifyListeners();
  }

  removeTodo(TodoItem item) {
    _tasks.removeAt(_tasks.indexOf(item));
    _storageService.saveTodos(_tasks);

    notifyListeners();
  }

  updateTodo(TodoItem todoItem, String newTitle) {
    var index = _tasks.indexOf(todoItem);
    _tasks[index].title = newTitle;
    _storageService.saveTodos(_tasks);
    notifyListeners();
  }

  toggleCompletion(TodoItem item) {
    var index = _tasks.indexOf(item);
    _tasks[index].toggle();
    _storageService.saveTodos(_tasks);
    notifyListeners();
  }
}
