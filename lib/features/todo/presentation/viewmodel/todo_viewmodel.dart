import 'package:flutter/material.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

class ToDoViewModel extends ChangeNotifier {
  final ToDoRepository repo;
  final _uuid = const Uuid();

  List<ToDo> _todos = [];
  List<ToDo> get todos => _todos;

  ToDoViewModel(this.repo) {
    _todos = repo.getAll();
  }

  void add(String title) async {
    final todo = ToDo(id: _uuid.v4(), title: title);
    await repo.add(todo);
    _todos = repo.getAll();
    notifyListeners();
  }

  void toggle(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(isDone: !todo.isDone);
    await repo.update(updated);
    _todos = repo.getAll();
    notifyListeners();
  }

  void delete(String id) async {
    await repo.delete(id);
    _todos = repo.getAll();
    notifyListeners();
  }
}
