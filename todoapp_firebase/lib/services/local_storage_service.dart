import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_interface.dart';

class LocalStorageService implements StorageServiceInterface {
  late SharedPreferences prefs;
  String get KEY => 'todos';

  LocalStorageService._create() {
    print("_create() (private constructor)");
  }

  static Future<StorageServiceInterface> initialize() async {
    var service = LocalStorageService._create();
    service.prefs = await SharedPreferences.getInstance();

    // service.prefs.clear();
    return service;
  }

  List<TodoItem> getFromStorage() {
    var todos = prefs.getString(KEY);
    if (todos != null) {
      var json = jsonDecode(todos) as List<dynamic>;
      var todoItems = json.map((e) => TodoItem.fromJson(e)).toList();
      return todoItems;
    }
    return [];
  }

  @override
  Future<void> create(String userId, TodoItem item) async {
    var todos = [...getFromStorage(), item];
    await prefs.setString(KEY, jsonEncode(todos));
    print("CREATED");
  }

  @override
  Future<void> deleteTodo(String userId, String docId) async {
    var todos = getFromStorage();
    todos.removeWhere((element) => element.docId == docId);
    await prefs.setString(KEY, jsonEncode(todos));
    print("Deleted");
  }

  @override
  Future<List<TodoItem>> getTodos(String userId) async {
    var todos = prefs.getString(KEY);
    if (todos != null) {
      var json = jsonDecode(todos) as List<dynamic>;
      return json.map((e) => TodoItem.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<TodoItem> updateTodo(
      String userId, String docId, TodoItem item) async {
    var todos = getFromStorage();
    var index = todos.indexWhere((element) => element.docId == docId);
    todos[index] = item;
    await prefs.setString(KEY, jsonEncode(todos));

    return item;
  }

  @override
  Future<void> createMany(String userId, List<TodoItem> items) async {
    await prefs.setString(KEY, jsonEncode(items));
  }

  @override
  Future<void> deleteAll(String userId) async {
    await prefs.remove(KEY);
    // throw UnimplementedError();
  }
}
