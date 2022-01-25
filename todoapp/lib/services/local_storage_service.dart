import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';

import 'storage_interface.dart';

late SharedPreferences prefs;

class LocalStorageService implements StorageServiceInterface {
  @override
  Future<LocalStorageService> initialize() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  void saveTodos(List<TodoItem> tasks) {
    prefs.setString('tasks', jsonEncode(tasks));
  }

  @override
  List<TodoItem> getTodos() {
    var storedData = prefs.getString('tasks');
    print(storedData);
    if (storedData != null) {
      var objects = jsonDecode(storedData) as List<dynamic>;
      return objects.map((e) => TodoItem.fromJson(e)).toList();
    }
    return [];
  }
}
