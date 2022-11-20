import 'package:flutter/material.dart';

import '../../models/app_model.dart';
import '../../shared/controller.dart';
import '../../shared/repository.dart';
import '../add_task/add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TaskController(Repository());
  late List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: FutureBuilder(
        future: controller.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Não tem tarefas."),
              );
            }
            tasksList = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: tasksList.length,
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    tasksList[index].doIt();
                    await controller.updateTask(tasksList[index]);
                    setState(() {});
                  } else {
                    await controller.deleteTask(tasksList[index]);
                    setState(() {});
                  }
                },
                child: ListTile(
                  title: Text(tasksList[index].titulo),
                  subtitle: Text(tasksList[index].descricao),
                  trailing:
                      tasksList[index].done ? const Icon(Icons.done) : null,
                ),
              ),
            );
          }
          return Center(
            child: snapshot.hasError
                ? const Text('Aconteceu algo errado. \nTente mais tarde.')
                : const CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddTaskPage(),
          ),
        )
            .then((_) {
          setState(() {});
        }),
        tooltip: 'Nova',
        child: const Icon(Icons.add),
      ),
    );
  }
}
