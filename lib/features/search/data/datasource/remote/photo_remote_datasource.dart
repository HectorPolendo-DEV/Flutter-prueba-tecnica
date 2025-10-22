import '../../models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> search(String term, {int page, int perPage});
}
