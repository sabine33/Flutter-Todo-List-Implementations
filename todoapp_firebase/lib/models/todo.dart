class TodoItem {
  String title;
  bool isCompleted;
  String docId;
  String timestamp = DateTime.now().toString();

  TodoItem(
      {required this.title, required this.isCompleted, required this.docId});

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
  int get hashCode => super.hashCode;

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
