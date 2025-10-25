import 'package:dio/dio.dart';
import 'package:user_app_assessment/app/core/network/api_interceptor.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/environment.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String baseUrl = UrlContainer.baseUrl}) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.add(ApiInterceptor(apiKey: Environment.API_KEY));
  }

  /// GET method
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// POST method
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }


  /// Optional: handle or log error types cleanly
  void _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      printE("⚠️ Connection timeout");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      printE("⚠️ Receive timeout");
    } else if (e.type == DioExceptionType.badResponse) {
      printE("⚠️ Server error: ${e.response?.statusCode}");
    } else {
      printE("⚠️ Unexpected error: ${e.message}");
    }
  }
}
