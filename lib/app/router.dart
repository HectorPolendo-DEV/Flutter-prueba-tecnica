import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/view/home_page.dart';
import '../features/tips/presentation/view/tips_page.dart';
import '../features/todo/presentation/view/to_do_page.dart';
import '../features/search/presentation/view/search_page.dart';

sealed class AppRoutes {
  static const home = '/';
  static const tips = '/tips';
  static const todo = '/todo';
  static const search = '/search';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePage(),
      routes: [
        GoRoute(path: 'tips', builder: (_, __) => const TipsPage()),
        GoRoute(path: 'todo', builder: (_, __) => const TodoPage()),
        GoRoute(path: 'search', builder: (_, __) => const SearchPage()),
      ],
    ),
  ],
  errorBuilder: (BuildContext context, state) => Scaffold(
    appBar: AppBar(title: const Text('No encontrado')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ruta inválida: ${state.uri}'),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Volver al inicio'),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
    ),
  ),
);
