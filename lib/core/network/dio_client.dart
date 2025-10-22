import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;

  DioClient({String? baseUrl, String? accessKey}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          if ((accessKey ?? '').isNotEmpty)
            'Authorization': 'Client-ID $accessKey',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[${options.method}] ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('[${response.statusCode}] ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (e, handler) {
          print('Error: ${e.message}');
          handler.next(e);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }
}
