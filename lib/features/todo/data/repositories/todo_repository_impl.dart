import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasource/local/todo_local_datasource.dart';
import '../models/todo_model.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoLocalDataSource local;

  ToDoRepositoryImpl(this.local);

  @override
  List<ToDo> getAll() => local.getAll().map((e) => e.toEntity()).toList();

  @override
  Future<void> add(ToDo todo) async =>
      await local.add(ToDoModel.fromEntity(todo));

  @override
  Future<void> delete(String id) async => await local.delete(id);

  @override
  Future<void> update(ToDo todo) async =>
      await local.update(ToDoModel.fromEntity(todo));
}
