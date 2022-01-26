import 'package:todoapp/models/todo.dart';

abstract class StorageServiceInterface {
  Future<void> create(String userId, TodoItem item);
  Future<void> saveTodos(String userId, List<TodoItem> items);
  Future<List<TodoItem>> getTodos(String userId);
  Future<TodoItem> updateTodo(String userId, String docId, TodoItem item);
  Future<void> deleteTodo(String userId, String docId);
  Future<void> deleteAll(String userId);
}
