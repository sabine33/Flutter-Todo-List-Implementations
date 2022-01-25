import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo_provider.dart';
import 'package:todoapp/services/local_storage_service.dart';
import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // mandatory when awaiting on main

  final repository = await LocalStorageService().initialize();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return TodoListProvider(repository);
      },
      child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Challenges #1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(title: 'To Do Application'),
    );
  }
}
