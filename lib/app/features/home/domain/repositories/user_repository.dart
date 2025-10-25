import '../../data/models/users_list_response_model.dart';

abstract class UserRepository {
  Future<UserListResponseModel> getUsers({required int page, required int limit});
}
