import 'package:flutter/material.dart';

import '../../models/app_model.dart';
import '../../shared/controller.dart';
import '../../shared/repository.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final controller = TaskController(Repository());
  final _formKey = GlobalKey<FormState>();

  final tituloController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova tarefa')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Título'),
              style: const TextStyle(fontSize: 18),
              controller: tituloController,
              validator: (value) {
                return tituloController.text.isEmpty ? 'Required field' : null;
              },
            ),
            const Divider(),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Descrição'),
              controller: descController,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processando...')),
                      );
                      await controller.createTask(
                        Task(
                            titulo: tituloController.text,
                            descricao: descController.text),
                      );
                      // ------------------------
                      // Do not use BuildContexts across async gaps
                      // https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps
                      if (!mounted) return;
                      // ------------------------
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('SALVAR'),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
