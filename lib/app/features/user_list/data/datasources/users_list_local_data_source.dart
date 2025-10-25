import 'package:user_app_assessment/app/core/service/hive_service.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';

abstract class UsersListLocalDataSource {
  Future<void> cacheUsersList(List<UserModel> users);
  List<UserModel> getCachedUsersList();
}

class UsersListLocalDataSourceImpl implements UsersListLocalDataSource {
  final HiveService hiveService;

  UsersListLocalDataSourceImpl({required this.hiveService});

  @override
  Future<void> cacheUsersList(List<UserModel> users) async {
    await hiveService.cacheUsersList(users);
  }

  @override
  List<UserModel> getCachedUsersList() {
    return hiveService.getCachedUsersList();
  }
}
