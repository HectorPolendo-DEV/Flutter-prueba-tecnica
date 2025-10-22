import 'package:flutter/foundation.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final PhotoRepository repo;

  bool isLoading = false;
  String? error;
  List<Photo> results = [];
  int _page = 1;
  String _term = '';

  SearchViewModel(this.repo);

  Future<void> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;

    isLoading = true;
    error = null;
    _term = q;
    _page = 1;
    notifyListeners();

    try {
      results = await repo.search(q, page: _page);
    } catch (e) {
      error = e.toString();
      results = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (isLoading || _term.isEmpty) return;
    isLoading = true;
    notifyListeners();
    try {
      _page += 1;
      final more = await repo.search(_term, page: _page);
      results = List.of(results)..addAll(more);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    results = [];
    _term = '';
    _page = 1;
    error = null;
    notifyListeners();
  }
}
