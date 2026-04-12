abstract class ApiService {
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}