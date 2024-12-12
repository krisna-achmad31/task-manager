class ToDo {
  int? id;
  String title;
  String description;
  bool isDone;
  DateTime date;
  DateTime? time;
  int order;
  String? priority;

  ToDo({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
    this.time,
    this.order = 0,
    this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
      'date': date.toIso8601String(),
      'time': time?.toIso8601String(),
      'order': order,
      'priority': priority,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'] == 1,
      date: DateTime.parse(map['date']),
      time: DateTime.parse(map['time']),
      order: map['order'],
      priority: map['priority'],
    );
  }
}