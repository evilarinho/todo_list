import 'dart:convert';

class Task {
  Task({
    required this.titulo,
    required this.descricao,
    bool done = false,
    String? id,
  })  : _done = done,
        _id = id;

  String? _id;
  String titulo;
  String descricao;
  bool _done;

  String? get id => _id;
  bool get done => _done;

  void doIt() => _done = true;

  void undoIt() => _done = false;

  factory Task.fromMap(Map<String, dynamic> source) => Task(
      titulo: source['titulo'],
      descricao: source['descricao'],
      done: source['done'],
      id: source['_id']);

  factory Task.fromJson(json) => Task.fromMap(json);

  Map<String, dynamic> toMap() => {
        'titulo': titulo,
        'descricao': descricao,
        'done': _done,
      };

  String toJson() => jsonEncode(toMap());
}
