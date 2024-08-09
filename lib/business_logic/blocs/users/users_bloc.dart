import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:morningstar/data/repositories/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository userRepository = UsersRepository();

  UsersBloc() : super(UsersInitialState()) {
    on<CurrentUserDetails>(_getUserDetailStream);
    on<CurrentUserDetailsData>(_getUserDetail);
  }

  Future<void> _getUserDetailStream(
    CurrentUserDetails event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      print('----current user----');
      print(user);
      final userStream = await userRepository.getUserByIdStream(uuid: user!.uid);
      print('----current user stream----');
      print(userStream);
      print('----current user stream close----');
      emit(UserLoadedState(userStream));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _getUserDetail(
    CurrentUserDetailsData event,
    Emitter<UsersState> emit,
  ) async {
  emit(UserLoadingState());
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    
    print('----current user----');
    print(user);

    final userDocument = await userRepository.getUserById(uuid: user.uid);
    if (userDocument.exists) {
      final userData = userDocument.data();
      print('----current user data----');
      print(userData);

      emit(UserLoadedStateData(userData));
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    emit(UserErrorState(e.toString()));
  }
}
}
