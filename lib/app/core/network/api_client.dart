import 'dart:io';

import 'package:dio/dio.dart';
import 'package:user_app_assessment/app/core/network/api_interceptor.dart';
import 'package:user_app_assessment/app/core/shared/data/model/api_response_model.dart';
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
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ApiResponse.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      final errorMessage = _handleError(e);
      return ApiResponse.failure(errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      return ApiResponse.failure("⚠️ Unexpected error: $e");
    }
  }

  /// POST method
  Future<ApiResponse> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      final errorMessage = _handleError(e);
      return ApiResponse.failure(errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      return ApiResponse.failure("⚠️ Unexpected error: $e");
    }
  }

  /// Handle DioException and return proper error message
  String _handleError(DioException e) {
    String errorMessage;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "⚠️ Connection timeout. Please check your internet.";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "⚠️ Connection Error. Please check your internet.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "⚠️ Request timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "⚠️ Response timeout. Please try again later.";
        break;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final serverMessage = e.response?.data['message'] ?? e.message;
        errorMessage = "⚠️ Server error ($statusCode): $serverMessage";
        break;
      case DioExceptionType.cancel:
        errorMessage = "⚠️ Request was cancelled.";
        break;

      case DioExceptionType.unknown:
      default:
        // Detect no internet
        if (e.error is SocketException) {
          errorMessage = "⚠️ No internet connection. Please check your network.";
        } else {
          errorMessage = "⚠️ Unexpected error occurred: ${e.message}";
        }
        break;
    }

    return errorMessage;
  }
}
