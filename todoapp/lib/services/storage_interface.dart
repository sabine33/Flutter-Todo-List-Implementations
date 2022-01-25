import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_service.dart';

abstract class LocalStorageServiceInterface {
  Future<LocalStorageService> initialize();
  void saveTodos(List<TodoItem> tasks);
  List<TodoItem> getTodos();
}
