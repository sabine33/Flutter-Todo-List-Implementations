class TodoItem {
  String title;
  bool isCompleted;
  String timestamp = DateTime.now().toString();

  TodoItem({required this.title, required this.isCompleted});

  static TodoItem copyFrom(TodoItem item) {
    return TodoItem(title: item.title, isCompleted: item.isCompleted);
  }

  toggle() {
    isCompleted = !isCompleted;
  }

  @override
  bool operator ==(covariant TodoItem other) =>
      other.title == title && timestamp == other.timestamp;

  @override
  int get hashCode => super.hashCode;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isCompleted = json['isCompleted'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
        'timestamp': timestamp,
      };
}
