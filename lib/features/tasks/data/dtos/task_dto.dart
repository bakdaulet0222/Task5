

class TaskDTO {
  String title;

  TaskDTO({required this.title});
}

class TodoDTO {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoDTO({required this.userId, required this.id, required this.title, required this.completed});

  factory TodoDTO.fromJson(Map<String, dynamic> json) {
    return TodoDTO(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}