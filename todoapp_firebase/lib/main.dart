import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo_provider.dart';
import 'package:todoapp/services/firebase_storage_service.dart';
import 'screens/homepage.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = await FirebaseStorageService.initialize();
  final provider = await TodoListProvider.initialize(repository);
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return provider;
      },
      child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Challenges #3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(title: 'To Do application with riverpod'),
    );
  }
}
