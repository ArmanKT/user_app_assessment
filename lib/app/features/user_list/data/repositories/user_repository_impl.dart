import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_remote_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/users_list_response_model.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UsersListRemoteDataSource usersListRemoteDataSource;
  UserRepositoryImpl({required this.usersListRemoteDataSource});

  @override
  Future<UserListResponseModel> getUsers({required int page, required int limit}) {
    return usersListRemoteDataSource.getUsers(page: page, limit: limit);
  }
}
