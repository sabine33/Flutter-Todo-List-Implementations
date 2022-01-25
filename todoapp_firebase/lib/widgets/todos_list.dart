import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/todo_provider.dart';
import 'todo_tile.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListProvider>(builder: (context, todoProvider, child) {
      return ListView.builder(
          itemCount: todoProvider.tasks.length,
          itemBuilder: (_, index) {
            var todoItem = todoProvider.tasks[index];
            return TodoTile(
              todoItem: todoItem,
              onRemoved: () {
                todoProvider.removeTodo(todoItem);
              },
              onTaskUpdated: (title) {
                todoProvider.updateTodo(todoItem, title);
              },
              onToggleCompletionStatus: () {
                todoProvider.toggleCompletion(todoItem);
              },
            );
          });
    });
  }
}
