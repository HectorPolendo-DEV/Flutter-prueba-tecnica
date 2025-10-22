import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException('Receive timeout');
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        final msg = error.response?.statusMessage ?? 'Unknown server error';
        return ApiException(msg, code);
      case DioExceptionType.connectionError:
        return ApiException('No internet connection');
      default:
        return ApiException(error.message ?? 'Unexpected error');
    }
  }

  @override
  String toString() => 'ApiException: $message (code: $statusCode)';
}
