import 'package:dio/dio.dart';

import '../models/app_model.dart';

class Repository {
  final String _myCrudcrudId = 'd664e20d28ef41618b172292e9226547';
  Future<List<Task>> getAllTasks() async {
    final response =
        await Dio().get('https://crudcrud.com/api/$_myCrudcrudId/tasks');
    final data = response.data.isNotEmpty ? response.data : [];
    return List.from(data.map((e) => Task.fromMap(e)));
  }

  Future<void> createTask(String jsonTask) async {
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
