import '../entities/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> search(String term, {int page});
}
