import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';
import 'package:user_app_assessment/app/features/user_list/domain/usecases/user_date_usecase.dart';
import 'package:user_app_assessment/environment.dart';

import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserDateUseCase userListDataUseCase;

  UserListBloc({required this.userListDataUseCase}) : super(UserListInitial()) {
    on<FetchUserListEvent>(_onFetchUserList);
    on<RefreshUserListEvent>(_onRefreshUserList);
    on<SearchUserListEvent>(_onSearchUserList);
  }

  int _page = 1;
  final int _limit = Environment.LIMIT_PER_PAGE;
  bool _hasNextPage = true;
  final List<UserModel> _usersList = [];

  Future<void> _onFetchUserList(
    FetchUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    try {
      // Stop if no next page
      if (!_hasNextPage) return;

      if (_page == 1) {
        emit(UserListLoading());
      }

      final response = await userListDataUseCase(page: _page, limit: _limit);

      if (response.data.isEmpty) {
        if (_page == 1) {
          emit(UserListNoMoreData());
        } else {
          _hasNextPage = false;
          emit(UserListLoaded(users: _usersList, hasNextPage: false));
        }
        return;
      }
      // Add new data to existing list
      _usersList.addAll(response.data);
      _hasNextPage = response.hasNextPage;
      emit(UserListLoaded(users: _usersList, hasNextPage: _hasNextPage));

      if (_hasNextPage) {
        _page++;
      }
    } catch (e) {
      emit(UserListError(message: e.toString()));
    }
  }

  Future<void> _onRefreshUserList(
    RefreshUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    // reset pagination
    _page = 1;
    _hasNextPage = true;
    _usersList.clear();

    emit(UserListLoading());
    add(const FetchUserListEvent());
  }

  Future<void> _onSearchUserList(
    SearchUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    final rawQuery = event.query.trim().toLowerCase();
    final query = rawQuery.replaceAll(RegExp(r'\s+'), ' ');

    if (query.isEmpty) {
      emit(UserListLoaded(users: _usersList, hasNextPage: _hasNextPage));
      return;
    }

    final sanitizedPattern = RegExp.escape(query);
    final regex = RegExp(sanitizedPattern, caseSensitive: false);

    final filteredUsers = _usersList.where((user) {
      final fullName = user.fullName.toLowerCase();
      final email = user.email.toLowerCase();
      return regex.hasMatch(fullName) || regex.hasMatch(email);
    }).toList();

    emit(UserListLoaded(users: filteredUsers, hasNextPage: false));
  }
}
