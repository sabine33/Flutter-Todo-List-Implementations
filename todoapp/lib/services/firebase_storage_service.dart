import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_interface.dart';

class FirebaseStorageService implements StorageServiceInterface {
  @override
  Future<StorageServiceInterface> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  List<TodoItem> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  void saveTodos(List<TodoItem> tasks) {
    // TODO: implement saveTodos
  }
}
