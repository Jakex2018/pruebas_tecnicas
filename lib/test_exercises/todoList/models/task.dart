import 'dart:convert';

class Task {
  final String title;
  final String? description;
  final bool isCompleted;

  Task({
    required this.title,
    this.description,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
      };

  String toJson() => jsonEncode(toMap());

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        title: map['title'],
        description: map['description'],
        isCompleted: map['isCompleted'] ?? false,
      );

  factory Task.fromJson(String source) => Task.fromMap(jsonDecode(source));
}
