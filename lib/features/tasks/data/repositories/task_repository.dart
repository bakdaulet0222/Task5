

import '../dtos/task_dto.dart';
import '../../service/task_service.dart';

class TaskRepository {
  final List<TaskDTO> _tasks = [];

  List<TaskDTO> get tasks => List.unmodifiable(_tasks);

  void addTask(TaskDTO task) {
    _tasks.add(task);
  }
}

class TodoRepository {
  final TodoService _todoService = TodoService();

  Future<TodoDTO> getTodo() async {
    final json = await _todoService.fetchTodo();
    return TodoDTO.fromJson(json);
  }
}