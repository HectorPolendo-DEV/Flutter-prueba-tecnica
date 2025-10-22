import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasource/remote/photo_remote_datasource.dart';
import '../mappers/photo_mapper.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remote;
  PhotoRepositoryImpl(this.remote);

  @override
  Future<List<Photo>> search(String term, {int page = 1}) async {
    final models = await remote.search(term, page: page);
    return models.map((m) => m.toEntity()).toList();
  }
}
