import '../entities/todo.dart';

abstract class ToDoRepository {
  List<ToDo> getAll();
  Future<void> add(ToDo todo);
  Future<void> delete(String id);
  Future<void> update(ToDo todo);
}
