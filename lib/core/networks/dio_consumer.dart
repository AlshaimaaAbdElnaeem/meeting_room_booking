import 'package:dio/dio.dart';
import 'package:meeting_room_booking/core/errors/failure.dart';
import 'api_service.dart';
import 'end_points.dart';

class DioConsumer extends ApiService {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(endPoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  ServerFailure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Connection timeout');

      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'No internet connection');

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode);

      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request cancelled');

      default:
        return const ServerFailure(message: 'Unexpected error');
    }
  }

  ServerFailure _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400: return const ServerFailure(message: 'Bad request');
      case 401: return const ServerFailure(message: 'Unauthorized');
      case 403: return const ServerFailure(message: 'Forbidden');
      case 404: return const ServerFailure(message: 'Not found');
      case 500: return const ServerFailure(message: 'Server error');
      default:  return ServerFailure(message: 'Error: $statusCode');
    }
  }
}