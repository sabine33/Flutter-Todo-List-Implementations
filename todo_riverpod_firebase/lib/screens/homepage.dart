import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/todo_state_provider.dart';
import 'package:todoapp/widgets/add_task_dialog.dart';
import 'package:todoapp/widgets/todos_list.dart';

class Homepage extends ConsumerWidget {
  final String title;
  const Homepage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoNotifier = ref.watch(itemListControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                todoNotifier.clearAll();
              },
              icon: Icon(Icons.clear_all))
        ],
      ),
      body: Center(child: TodosList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AddTaskDialog(
                    onTaskAdded: (title) {
                      todoNotifier.addTodo(title);
                    },
                    todoItem: null,
                  ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
