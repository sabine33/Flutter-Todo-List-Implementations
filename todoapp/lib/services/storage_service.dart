import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';

import 'shared_prefs.dart';

const KEY = "tasks";
late SharedPreferences prefs;

class StorageService {
  static Future initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveTodos(List<TodoItem> tasks) {
    prefs.setString('tasks', jsonEncode(tasks));
  }

  static List<TodoItem> getTodos() {
    var storedData = prefs.getString('tasks');
    print(storedData);
    if (storedData != null) {
      var objects = jsonDecode(storedData) as List<dynamic>;
      return objects.map((e) => TodoItem.fromJson(e)).toList();
    }
    return [];
  }
}
