import 'package:user_app_assessment/app/features/home/data/models/users_list_response_model.dart';
import 'package:user_app_assessment/app/features/home/domain/repositories/user_repository.dart';

class UserDateUseCase {
  final UserRepository userRepository;
  UserDateUseCase({required this.userRepository});

  Future<UserListResponseModel> call({required int page, required int limit}) {
    return userRepository.getUsers(page: page, limit: limit);
  }
}
