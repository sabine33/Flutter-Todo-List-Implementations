import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';

typedef void OnTaskUpdate(String title);
typedef void OnTaskAdded(String title);

class AddTaskDialog extends StatelessWidget {
  final TodoItem? todoItem;
  final OnTaskAdded? onTaskAdded;
  final OnTaskUpdate? onTaskUpdate;

  const AddTaskDialog(
      {Key? key, this.onTaskAdded, required this.todoItem, this.onTaskUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: todoItem?.title ?? 'New Task');
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
        child: Dialog(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Todo text",
                    ),
                    maxLines: 1,
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      if (todoItem == null) {
                        onTaskAdded!(controller.text);
                      } else {
                        onTaskUpdate!(controller.text);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void onTaskUpdated(TodoItem? todoItem) {}
