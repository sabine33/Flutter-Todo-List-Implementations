import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_interface.dart';

class LocalStorageService extends StorageServiceInterface {
  final String _KEY_ = "todos";

  @override
  Future<void> create(String userId, TodoItem item) async {}

//retrieve todos
  @override
  Future<List<TodoItem>> getTodos(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var json = prefs.getString(_KEY_);
      if (json != null) {
        var list = jsonDecode(json) as List<dynamic>;
        var output = list.map((e) => TodoItem.fromJson(e)).toList();
        print(output);
        return output;
      }
    } catch (ex) {
      print(ex);
      return [];
    }
    return [];
  }

//save todos
  @override
  Future<void> saveTodos(String userId, List<TodoItem> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_KEY_, jsonEncode(items));
  }

  @override
  Future<void> deleteAll(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String userId, String docId) {
    throw UnimplementedError();
  }

  @override
  Future<TodoItem> updateTodo(String userId, String docId, TodoItem item) {
    throw UnimplementedError();
  }
}
