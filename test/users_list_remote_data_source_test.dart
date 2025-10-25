import 'package:flutter_test/flutter_test.dart';
import 'package:user_app_assessment/app/core/network/api_client.dart';
import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_remote_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/users_list_response_model.dart';
import 'package:user_app_assessment/app/core/shared/data/model/api_response_model.dart';
import 'package:user_app_assessment/app/core/exceptions/exceptions.dart';

/// A small fake ApiClient to avoid adding mocking packages.
class FakeApiClient implements ApiClient {
  final ApiResponse Function(String path, {Map<String, dynamic>? queryParameters}) onGet;
  final ApiResponse Function(String path, {dynamic data})? onPost;

  FakeApiClient({required this.onGet, this.onPost});

  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return onGet(path, queryParameters: queryParameters);
  }
}

void main() {
  group('UsersListRemoteDataSourceImpl', () {
    test('returns UserListResponseModel when ApiClient returns success', () async {
      // fake JSON payload
      final payload = {
        "page": 1,
        "per_page": 2,
        "total": 2,
        "total_pages": 1,
        "data": [
          {"id": 1, "first_name": "Arman", "last_name": "Khan", "email": "arman@example.com", "avatar": "https://example.com/a.png"},
          {"id": 2, "first_name": "John", "last_name": "Smith", "email": "John@example.com", "avatar": "https://example.com/b.png"}
        ]
      };

      final fakeClient = FakeApiClient(onGet: (path, {queryParameters}) {
        return ApiResponse.success(payload, statusCode: 200);
      });

      final dataSource = UsersListRemoteDataSourceImpl(apiClient: fakeClient);

      // Act
      final result = await dataSource.getUsers(page: 1, limit: 2);

      // Assert
      expect(result, isA<UserListResponseModel>());
      expect(result.data.length, 2);
      expect(result.data.first.id, 1);
      expect(result.data.first.firstName, 'Arman');
    });

    test('throws ServerException when ApiClient returns failure', () async {
      final fakeClient = FakeApiClient(onGet: (path, {queryParameters}) {
        return ApiResponse.failure('Server error', statusCode: 500);
      });

      final dataSource = UsersListRemoteDataSourceImpl(apiClient: fakeClient);

      // Act & Assert
      expect(() => dataSource.getUsers(page: 1, limit: 2), throwsA(isA<ServerException>()));
    });
  });
}
