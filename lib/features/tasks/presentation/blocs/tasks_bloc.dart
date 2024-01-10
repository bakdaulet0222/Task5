// lib/features/tasks/presentation/blocs/tasks_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5/features/tasks/data/dtos/task_dto.dart';
import 'package:task5/features/tasks/data/repositories/task_repository.dart';


// События Bloc
abstract class TasksEvent {}

class TaskAdded extends TasksEvent {
  final String title;

  TaskAdded(this.title);
}

// Состояния Bloc
abstract class TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<TaskDTO> tasks;

  TasksLoadSuccess(this.tasks);
}

// Bloc
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({required this.taskRepository}) : super(TasksLoadSuccess([])) {
    on<TaskAdded>((event, emit) {
      taskRepository.addTask(TaskDTO(title: event.title));
      emit(TasksLoadSuccess(taskRepository.tasks));
    });
  }
}