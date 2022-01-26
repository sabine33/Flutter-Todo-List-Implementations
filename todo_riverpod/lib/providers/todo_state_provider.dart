import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/local_storage_service.dart';
import 'package:todoapp/services/storage_interface.dart';

final localStorageProvider =
    Provider<StorageServiceInterface>((ref) => LocalStorageService());

final itemListControllerProvider =
    StateNotifierProvider<TodoListController, AsyncValue<List<TodoItem>>>(
  (ref) {
    final localService = ref.read(localStorageProvider);
    //auth provider=>user=>id
    return TodoListController(localService, "1");
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
    state.whenData((items) => state = AsyncValue.data(
        items..add(TodoItem(title: title, isCompleted: false, docId: null))));
    await storageService.saveTodos(userId, state.value!);
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

    storageService.saveTodos(userId, state.value!);
  }

  @override
  removeTodo(TodoItem _item) async {
    state.whenData((items) =>
        state = AsyncValue.data(items..removeWhere((item) => item == _item)));
    await storageService.saveTodos(userId, state.value!);
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

    await storageService.saveTodos(userId, state.value!);
  }

  @override
  toggleCompletion(TodoItem todoItem) async {
    state.whenData((items) {
      state = AsyncValue.data(items
        ..firstWhere((TodoItem element) => (element == todoItem)).isCompleted =
            !todoItem.isCompleted);
    });
    await storageService.saveTodos(userId, state.value!);
  }
}
