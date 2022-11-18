
import '../models/app_model.dart';
import 'repository.dart';

class TaskController {
  final Repository repository;

  TaskController(this.repository);

  Future<List<Task>> getAllTasks() async {
    return await repository.getAllTasks();
  }

  Future<void> createTask(Task task) async {
    final jsonTask = task.toJson();
    return await repository.createTodo(jsonTask);
  }

  Future<void> updateTask(Task task) async {
    final jsonTask = task.toJson();
    return await repository.updateTask(jsonTask, task.id ?? '');
  }

  Future<void> deleteTask(Task task) async {
    return await repository.deleteTask(task.id ?? '');
  }
}
