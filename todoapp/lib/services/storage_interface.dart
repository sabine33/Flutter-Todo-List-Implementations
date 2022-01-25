import 'package:todoapp/models/todo.dart';

abstract class StorageServiceInterface {
  Future<StorageServiceInterface> initialize();
  void saveTodos(List<TodoItem> tasks);
  List<TodoItem> getTodos();
}
