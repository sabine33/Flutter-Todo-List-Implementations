import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/firebase_storage.dart';
import 'package:todoapp/services/firebase_storage_service.dart';
import 'package:todoapp/services/local_storage_service.dart';
import 'package:todoapp/services/storage_interface.dart';

final firebaseStorageProvider =
    StateProvider<StorageServiceInterface>((ref) => firebaseStorageService);

final itemListControllerProvider =
    StateNotifierProvider<TodoListController, AsyncValue<List<TodoItem>>>(
  (ref) {
    final firebaseService = ref.read(firebaseStorageProvider);
    //auth provider=>user=>id
    return TodoListController(firebaseService, "1");
  },
);

abstract class TodoListInterface {
  void fetchTodos(String userId);
  void addTodo(String title);
  void createMany(String title);
  void toggleCompletion(TodoItem todoItem);
  void updateTodo(TodoItem updatedItem, String newTitle);
  void clearAll();
  void removeTodo(TodoItem todoItem);
}

class TodoListController extends StateNotifier<AsyncValue<List<TodoItem>>>
    implements TodoListInterface {
  late StorageServiceInterface storageService;
  String userId;
  // Reader _read;
  TodoListController(this.storageService, this.userId)
      : super(AsyncValue.loading()) {
    // storageService = _read(localStorageProvider);
    fetchTodos(userId);
  }

  @override
  void fetchTodos(String userId) async {
    state = const AsyncValue.loading();
    try {
      final items = await storageService.getTodos(userId);
      state = AsyncValue.data(items);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e);
    }
  }

  @override
  void addTodo(String title) async {
    var todoItem = TodoItem(title: title, isCompleted: false, docId: null);
    state.whenData((items) => state = AsyncValue.data(items..add(todoItem)));
    await storageService.create(userId, todoItem);
  }

  @override
  void createMany(String title) async {
    state.whenData((items) => state = AsyncValue.data(
        items..add(TodoItem(title: title, isCompleted: false, docId: null))));
    await storageService.saveTodos(userId, state.value!);
  }

  @override
  clearAll() async {
    state.whenData((items) => state = state = AsyncValue.data([]));

    storageService.deleteAll(userId);
  }

  @override
  removeTodo(TodoItem _item) async {
    state.whenData((items) =>
        state = AsyncValue.data(items..removeWhere((item) => item == _item)));
    await storageService.deleteTodo(userId, _item.docId!);
  }

  @override
  updateTodo(TodoItem updatedItem, String newTitle) async {
    state.whenData((items) {
      for (var item in items) {
        if (item == updatedItem) {
          item.title = newTitle;
        }
      }
      state = AsyncValue.data(items);
    });

    await storageService.updateTodo(userId, updatedItem.docId!, updatedItem);
  }

  @override
  toggleCompletion(TodoItem todoItem) async {
    state.whenData((items) {
      state = AsyncValue.data(items
        ..firstWhere((TodoItem element) => (element == todoItem)).isCompleted =
            !todoItem.isCompleted);
    });
    await storageService.updateTodo(userId, todoItem.docId!, todoItem);
  }
}
