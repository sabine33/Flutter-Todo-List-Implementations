import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/add_task_dialog.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todoItem;
  final Function onRemoved;
  final Function onToggleCompletionStatus;
  final onTaskUpdated;
  const TodoTile(
      {Key? key,
      required this.todoItem,
      required this.onRemoved,
      required this.onToggleCompletionStatus,
      this.onTaskUpdated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: todoItem.isCompleted ? TextDecoration.lineThrough : null);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        subtitle: Text(todoItem.timestamp),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AddTaskDialog(
                  onTaskUpdate: (title) {
                    onTaskUpdated(title);
                  },
                  todoItem: todoItem));
        },
        title: Text(todoItem.title, style: titleStyle),
        leading: Checkbox(
          onChanged: (status) {
            print(status);
            onToggleCompletionStatus();
          },
          value: todoItem.isCompleted,
        ),
        trailing: IconButton(
            onPressed: () {
              onRemoved();
            },
            icon: Icon(Icons.remove_circle)),
      ),
    );
  }
}
