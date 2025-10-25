class ApiResponse {
  final bool success;
  final int? statusCode;
  final dynamic data;
  final String? error;

  ApiResponse({required this.success, required this.statusCode, this.data, this.error});

  factory ApiResponse.success(dynamic data, {int? statusCode}) {
    return ApiResponse(success: true, statusCode: statusCode, data: data);
  }

  factory ApiResponse.failure(String error, {int? statusCode}) {
    return ApiResponse(success: false, statusCode: statusCode, error: error);
  }
}
