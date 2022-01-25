import 'dart:collection';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_interface.dart';

class TodoListProvider extends ChangeNotifier {
  late StorageServiceInterface _storageService;
  late List<TodoItem> _tasks;

  TodoListProvider._create() {
    print("_create() (private constructor)");

    // Do most of your initialization here, that's what a constructor is for
    //...
  }

  /// Public factory
  static Future<TodoListProvider> initialize(
      StorageServiceInterface service) async {
    print("create() (public factory)");
    // Call the private constructor
    var provider = TodoListProvider._create();
    provider._storageService = service;
    provider._tasks = await provider._storageService.getTodos('1');
    print(provider._tasks);
    return provider;
  }

  List<TodoItem> get tasks => UnmodifiableListView(_tasks);

  addTodo(String title) async {
    var todoItem =
        TodoItem(title: title, isCompleted: false, docId: '${_tasks.length}');
    _tasks.add(todoItem);
    // print(jsonEncode(_tasks));

    await _storageService.create('1', todoItem);
    print("ADDED");

    notifyListeners();
  }

  clearAll() async {
    _tasks.clear();
    await _storageService.deleteAll('1');
    notifyListeners();
  }

  removeTodo(TodoItem item) {
    _tasks.removeAt(_tasks.indexOf(item));
    _storageService.deleteTodo('1', item.docId);

    notifyListeners();
  }

  updateTodo(TodoItem todoItem, String newTitle) {
    var index = _tasks.indexOf(todoItem);
    _tasks[index].title = newTitle;
    _storageService.updateTodo('1', todoItem.docId, todoItem);
    notifyListeners();
  }

  toggleCompletion(TodoItem item) {
    var index = _tasks.indexOf(item);
    _tasks[index].toggle();
    _storageService.updateTodo('1', item.docId, _tasks[index]);
    notifyListeners();
  }
}
