import 'package:hive/hive.dart';
import '../../domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isDone;

  ToDoModel({required this.id, required this.title, this.isDone = false});

  factory ToDoModel.fromEntity(ToDo todo) =>
      ToDoModel(id: todo.id, title: todo.title, isDone: todo.isDone);

  ToDo toEntity() => ToDo(id: id, title: title, isDone: isDone);
}
