import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:morningstar/data/repositories/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository userRepositoy = UsersRepository();

  UsersBloc() : super(UsersInitialState()) {
    on<CurrentUserDetails>(_getUserDetail);
  }

  Future<void> _getUserDetail(
    CurrentUserDetails event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      print('----current user----');
      print(user);
      final userStream = await userRepositoy.getUserById(uuid: user!.uid);
      print('----current user stream----');
      print(userStream);
      print('----current user stream close----');
      emit(UserLoadedState(userStream));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
