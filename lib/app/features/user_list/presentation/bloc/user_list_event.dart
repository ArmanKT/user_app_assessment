import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserListEvent extends UserListEvent {
  const FetchUserListEvent();
}

class RefreshUserListEvent extends UserListEvent {
  const RefreshUserListEvent();
}

class SearchUserListEvent extends UserListEvent {
  final String query;
  const SearchUserListEvent(this.query);

  @override
  List<Object?> get props => [query];
}
