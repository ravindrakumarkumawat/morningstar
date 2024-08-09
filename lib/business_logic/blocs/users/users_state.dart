part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitialState extends UsersState {}

class UserLoadingState extends UsersState {}

class UserLoadedState extends UsersState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> userStream;

  const UserLoadedState(this.userStream);
}

class UserLoadedStateData extends UsersState {
  final Map<String, dynamic>? userData;

  const UserLoadedStateData(this.userData);
}

class UserErrorState extends UsersState {
  final String message;

  const UserErrorState(this.message);
}
