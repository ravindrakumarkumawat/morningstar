part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersCurrentDetailsEvent extends UsersEvent {}

class UsersCurrentDetailsDataEvent extends UsersEvent {}
