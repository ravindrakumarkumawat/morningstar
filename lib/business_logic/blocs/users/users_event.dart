part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserDetails extends UsersEvent {}

class CurrentUserDetailsData extends UsersEvent {}
