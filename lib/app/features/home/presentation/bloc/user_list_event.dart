import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserListEvent extends UserListEvent {
  final int page;
  final int limit;

  const FetchUserListEvent({
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [page, limit];
}