import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/viewmodel/todo_viewmodel.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../data/datasource/local/todo_local_datasource.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/todo_model.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initHive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error al inicializar Hive: ${snapshot.error}'),
            ),
          );
        }

        final box = snapshot.data as Box<ToDoModel>;
        return ChangeNotifierProvider(
          create: (_) =>
              ToDoViewModel(ToDoRepositoryImpl(ToDoLocalDataSource(box))),
          child: const _ToDoView(),
        );
      },
    );
  }

  Future<Box<ToDoModel>> _initHive() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ToDoModelAdapter());
    }
    return await Hive.openBox<ToDoModel>('todosBox');
  }
}

class _ToDoView extends StatelessWidget {
  const _ToDoView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ToDoViewModel>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Añadir una tarea…',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => vm.add(controller.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: vm.add,
            ),
          ),
          Expanded(
            child: vm.todos.isEmpty
                ? const Center(child: Text('No hay tareas por hacer.'))
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: vm.todos.isEmpty ? 0.5 : 1.0,
                      child: ListView.builder(
                        itemCount: vm.todos.length,
                        itemBuilder: (context, index) {
                          final todo = vm.todos[index];
                          return Column(
                            children: [
                              Dismissible(
                                key: Key(todo.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (_) => vm.delete(todo.id),
                                child: CheckboxListTile(
                                  value: todo.isDone,
                                  title: Text(
                                    todo.title,
                                    style: TextStyle(
                                      decoration: todo.isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  onChanged: (_) => vm.toggle(todo.id),
                                ),
                              ),
                              const Divider(height: 1),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
