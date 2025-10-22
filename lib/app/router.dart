import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/view/home_page.dart';
import '../features/tips/presentation/view/tips_page.dart';
import '../features/todo/presentation/view/to_do_page.dart';
import '../features/search/presentation/view/search_page.dart';
import '../features/search/presentation/view/photo_detail_page.dart';
import '../features/search/domain/entities/photo.dart';

sealed class AppRoutes {
  static const home = '/';
  static const tips = '/tips';
  static const todo = '/todo';
  static const search = '/search';
  static const photoDetail = 'photo';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePage(),
      routes: [
        GoRoute(path: AppRoutes.tips, builder: (_, __) => const TipsPage()),
        GoRoute(path: AppRoutes.todo, builder: (_, __) => const TodoPage()),
        GoRoute(
          path: AppRoutes.search,
          builder: (_, __) => const SearchPage(),
          routes: [
            GoRoute(
              path: AppRoutes.photoDetail,
              builder: (context, state) {
                final photo = state.extra as Photo;
                return PhotoDetailPage(photo: photo);
              },
            ),
          ],
        ),
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
