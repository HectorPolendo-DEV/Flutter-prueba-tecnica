import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tile(String title, IconData icon, String route) {
      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.go(route),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 42),
                const SizedBox(height: 8),
                Text(title),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Prueba Técnica')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          tile('Tips', Icons.percent, AppRoutes.tips),
          tile('Todos', Icons.check_circle, AppRoutes.todo),
          tile('Search', Icons.image_search, AppRoutes.search),
        ],
      ),
    );
  }
}
