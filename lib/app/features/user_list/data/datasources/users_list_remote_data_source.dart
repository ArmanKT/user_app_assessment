import 'dart:convert';

import 'package:user_app_assessment/app/core/exceptions/exceptions.dart';
import 'package:user_app_assessment/app/core/network/api_client.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/users_list_response_model.dart';

abstract class UsersListRemoteDataSource {
  Future<UserListResponseModel> getUsers({required int page, required int limit});
}

class UsersListRemoteDataSourceImpl implements UsersListRemoteDataSource {
  final ApiClient apiClient;

  UsersListRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserListResponseModel> getUsers({required int page, required int limit}) async {
    try {
      final response = await apiClient.get(UrlContainer.users, queryParameters: {'page': page, 'per_page': limit});

      if (response.statusCode == 200) {
        return userListResponseModelFromJson(jsonEncode(response.data));
      } else {
        throw ServerException(AppStrings.fetchError);
      }
    } catch (e) {
      throw ServerException(AppStrings.fetchError);
    }
  }
}
