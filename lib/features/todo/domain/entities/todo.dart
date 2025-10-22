class ToDo {
  final String id;
  final String title;
  final bool isDone;

  ToDo({required this.id, required this.title, this.isDone = false});

  ToDo copyWith({String? id, String? title, bool? isDone}) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
