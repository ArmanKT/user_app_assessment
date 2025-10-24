import 'package:dio/dio.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';

class ApiInterceptor extends Interceptor {
  final String apiKey;

  ApiInterceptor({required this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['x-api-key'] = apiKey;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printI('Response: ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printE('Error: ${err.message}');
    if (err.response != null) {
      printE('Response data: ${err.response?.data}');
    }
    handler.next(err);
  }
}