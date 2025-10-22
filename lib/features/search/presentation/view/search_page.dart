import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../search/presentation/viewmodel/search_viewmodel.dart';
import '../../../../app/router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SearchView();
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Búsqueda de Fotos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar en Unsplash…',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => vm.search(controller.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: vm.search,
            ),
          ),
          if (vm.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Error: ${vm.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (n) {
                if (n.metrics.pixels > n.metrics.maxScrollExtent - 300 &&
                    !vm.isLoading) {
                  vm.loadMore();
                }
                return false;
              },
              child: _Grid(vm: vm),
            ),
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final SearchViewModel vm;
  const _Grid({required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.isLoading && vm.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.results.isEmpty) {
      return const Center(child: Text('Busca un término para ver resultados'));
    }

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: vm.results.length + (vm.isLoading ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= vm.results.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final p = vm.results[index];
        return GestureDetector(
          onTap: () {
            context.push(
              '${AppRoutes.search}/${AppRoutes.photoDetail}',
              extra: p,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: p.thumbUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const AspectRatio(
                    aspectRatio: 1,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, __, ___) => const AspectRatio(
                    aspectRatio: 1,
                    child: Icon(Icons.broken_image),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                p.title.isEmpty
                    ? 'Sin título'
                    : '${p.title[0].toUpperCase()}${p.title.substring(1).toLowerCase()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
