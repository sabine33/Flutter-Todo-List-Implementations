import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/todo_state_provider.dart';
import 'todo_tile.dart';

class TodosList extends ConsumerWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchman = ref.watch(itemListControllerProvider);
    final notifier = ref.watch(itemListControllerProvider.notifier);

    return watchman.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text("Todo list is empty. Please add some tasks."));
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                var todoItem = data[index];
                return TodoTile(
                  todoItem: todoItem,
                  onRemoved: () {
                    notifier.removeTodo(todoItem);
                  },
                  onTaskUpdated: (title) {
                    notifier.updateTodo(todoItem, title);
                  },
                  onToggleCompletionStatus: () {
                    notifier.toggleCompletion(todoItem);
                  },
                );
              });
        },
        error: (err, st) =>
            Center(child: Text("Error while loading the content.")),
        loading: () => CircularProgressIndicator());
  }
}
