import 'package:dio/dio.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/api_exceptions.dart';
import '../../models/photo_model.dart';
import 'photo_remote_datasource.dart';

class UnsplashRemoteDataSource implements PhotoRemoteDataSource {
  final DioClient _client;
  UnsplashRemoteDataSource(this._client);

  @override
  Future<List<PhotoModel>> search(
    String term, {
    int page = 1,
    int perPage = 30,
  }) async {
    try {
      final Response<Map<String, dynamic>> res = await _client
          .get<Map<String, dynamic>>(
            '/search/photos',
            queryParameters: {'query': term, 'page': page, 'per_page': perPage},
          );
      final list =
          (res.data?['results'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      return list.map(PhotoModel.fromJson).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
