import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_assessment/app/features/home/data/models/user_model.dart';
import 'package:user_app_assessment/app/features/home/domain/usecase/user_date_usecase.dart';

import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserDateUseCase userListDataUseCase;

  UserListBloc({required this.userListDataUseCase}) : super(UserListInitial()) {
    on<FetchUserListEvent>(_onFetchUserList);
  }

  Future<void> _onFetchUserList(
    FetchUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    try {
      if (event.page == 1) {
        emit(UserListLoading());
      }

      final response = await userListDataUseCase(
        page: event.page,
        limit: event.limit,
      );

      if (response.data.isEmpty) {
        // emit(UserListNoMoreData());
      } else {
        List<UserModel> currentUsers = [];

        if (state is UserListLoaded) {
          currentUsers = List.from((state as UserListLoaded).users);
        }
        currentUsers.addAll(response.data);

        emit(UserListLoaded(users: currentUsers, hasNextPage: response.hasNextPage));
      }
    } catch (e) {
      emit(UserListError(message: e.toString()));
    }
  }
}
