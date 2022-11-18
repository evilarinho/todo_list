import 'package:dio/dio.dart';

import '../models/app_model.dart';

class Repository {
  final String _myCrudcrudId = '7d887e16fabd4e83ae6db53a780c03aa';

  Future<List<Task>> getAllTasks() async {
    final response =
        await Dio().get('https://crudcrud.com/api/$_myCrudcrudId/tasks');
    final data = response.data.isNotEmpty ? response.data : [];
    return List.from(data.map((e) => Task.fromMap(e)));
  }

  Future<void> createTodo(String jsonTask) async {
    await Dio().post(
      'https://crudcrud.com/api/$_myCrudcrudId/tasks',
      data: jsonTask,
      options: Options(
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      ),
    );
  }

  Future<void> updateTask(String jsonTask, String id) async {
    await Dio().put(
      'https://crudcrud.com/api/$_myCrudcrudId/tasks/$id',
      data: jsonTask,
      options: Options(
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      ),
    );
  }

  Future<void> deleteTask(String id) async {
    await Dio().delete('https://crudcrud.com/api/$_myCrudcrudId/tasks/$id');
  }
}
