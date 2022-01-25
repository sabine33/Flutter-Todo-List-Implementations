import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/storage_interface.dart';

class FirebaseStorageService implements StorageServiceInterface {
  late FirebaseApp firebaseApp;
  late CollectionReference _collection;
  late FirebaseFirestore _firestore;

  FirebaseStorageService._create() {
    print("_create() (private constructor)");
  }

  static Future<StorageServiceInterface> initialize() async {
    var service = FirebaseStorageService._create();
    service.firebaseApp = await Firebase.initializeApp();
    service._firestore = FirebaseFirestore.instance;
    service._collection = service._firestore.collection('todos');
    return service;
  }

  @override
  Future<List<TodoItem>> getTodos(String userId) async {
    var documentReferencer = _collection.doc(userId).collection('items');

    var snapshots = await documentReferencer.get();
    List<TodoItem> items = [];
    // snapshots.docs.map((e) => TodoItem.fromJson(e.data())).toList()
    for (var item in snapshots.docs) {
      var json = item.data();
      items.add(TodoItem(
          title: json['title'],
          isCompleted: json['isCompleted'],
          docId: item.id));
    }

    return items;
  }

  @override
  Future<void> create(String userId, TodoItem item) async {
    var documentReferencer = _collection.doc(userId).collection('items');
    // item.docId = documentReferencer;
    await documentReferencer.add(item.toJson());
  }

  @override
  Future<void> deleteTodo(String userId, String docId) async {
    DocumentReference documentReferencer =
        _collection.doc(userId).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  @override
  Future<TodoItem> updateTodo(
      String userId, String docId, TodoItem item) async {
    DocumentReference documentReferencer =
        _collection.doc(userId).collection('items').doc(docId);

    Map<String, dynamic> data = item.toJson();

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));

    return item;
  }

  @override
  Future<void> createMany(String userId, List<TodoItem> items) {
    // TODO: implement createMany
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll(String userId) async {
    var documentReferencer = _collection.doc(userId).collection('items');
    var docs = await documentReferencer.get();
    for (var item in docs.docs) {
      print(item.id);
      await _collection.doc(userId).collection('items').doc(item.id).delete();
    }
  }
}
