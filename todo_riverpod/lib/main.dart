import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/todo_state_provider.dart';
import 'package:todoapp/services/local_storage_service.dart';
import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // mandatory when awaiting on main

  runApp(const ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Challenges #2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(title: 'ToDo application with riverpod'),
    );
  }
}
