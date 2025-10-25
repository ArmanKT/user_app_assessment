import 'package:equatable/equatable.dart';
import 'package:user_app_assessment/app/features/home/data/models/user_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserModel> users;
  final bool hasNextPage;

  const UserListLoaded({required this.users, required this.hasNextPage});

  @override
  List<Object?> get props => [users, hasNextPage];
}

class UserListNoMoreData extends UserListState {}

class UserListError extends UserListState {
  final String message;

  const UserListError({required this.message});

  @override
  List<Object?> get props => [message];
}
