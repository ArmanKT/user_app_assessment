import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:user_app_assessment/app/core/exceptions/exceptions.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_local_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_remote_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/users_list_response_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersListRemoteDataSource usersListRemoteDataSource;
  final UsersListLocalDataSource usersListLocalDataSource;
  final Connectivity connectivity;
  UserRepositoryImpl({required this.usersListRemoteDataSource, required this.usersListLocalDataSource, required this.connectivity});
  @override
  Future<UserListResponseModel> getUsers({
    required int page,
    required int limit,
  }) async {
    final connectivityResult = await connectivity.checkConnectivity();
    final hasInternet = !connectivityResult.contains(ConnectivityResult.none);

    if (hasInternet) {
      try {
        final remoteData = await usersListRemoteDataSource.getUsers(page: page, limit: limit);

        await usersListLocalDataSource.cacheUsersList(remoteData.data);

        return remoteData;
      } catch (e) {
        final cachedUsers = usersListLocalDataSource.getCachedUsersList();
        if (cachedUsers.isNotEmpty) {
          return UserListResponseModel(
            data: cachedUsers,
          );
        }
        rethrow;
      }
    } else {
      final cachedUsers = usersListLocalDataSource.getCachedUsersList();
      if (cachedUsers.isNotEmpty) {
        return UserListResponseModel(data: cachedUsers);
      } else {
        throw ServerException(AppStrings.noInternet);
      }
    }
  }
}
