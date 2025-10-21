import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tareas')),
      body: const Center(child: Text('To Do Page')),
    );
  }
}
