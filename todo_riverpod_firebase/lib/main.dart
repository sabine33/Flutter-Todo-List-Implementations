import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/todo_state_provider.dart';
import 'package:todoapp/services/local_storage_service.dart';
import 'screens/homepage.dart';
import 'services/firebase_storage.dart';
import 'services/firebase_storage_service.dart';
import 'services/storage_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // mandatory when awaiting on main
  final firebaseService = await initializeFirebase();
  runApp(ProviderScope(
      overrides: [firebaseStorageProvider.overrideWithValue(firebaseService)],
      child: TodoApp()));
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
