import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class TodoItem {
  String title;
  bool isCompleted;
  String? docId = _uuid.v4();
  String timestamp = DateTime.now().toString();

  TodoItem({required this.title, required this.isCompleted, this.docId});

  static TodoItem copyFrom(TodoItem item) {
    return TodoItem(
        title: item.title, isCompleted: item.isCompleted, docId: item.docId);
  }

  toggle() {
    isCompleted = !isCompleted;
  }

  @override
  bool operator ==(covariant TodoItem other) =>
      other.title == title &&
      timestamp == other.timestamp &&
      docId == other.docId;

  @override
  int get hashCode =>
      title.hashCode ^ timestamp.hashCode ^ isCompleted.hashCode;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isCompleted = json['isCompleted'],
        timestamp = json['timestamp'],
        docId = json['docId'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
        'timestamp': timestamp,
        'docId': docId
      };
}
