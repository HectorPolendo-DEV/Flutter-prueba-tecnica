import 'package:hive/hive.dart';
import '../../models/todo_model.dart';

class ToDoLocalDataSource {
  final Box<ToDoModel> box;

  ToDoLocalDataSource(this.box);

  List<ToDoModel> getAll() => box.values.toList();

  Future<void> add(ToDoModel todo) async => await box.put(todo.id, todo);

  Future<void> delete(String id) async => await box.delete(id);

  Future<void> update(ToDoModel todo) async => await box.put(todo.id, todo);
}
