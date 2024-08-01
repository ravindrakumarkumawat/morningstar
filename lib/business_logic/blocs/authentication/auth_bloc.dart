import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/utils/utils.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'package:morningstar/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<RegisterUser>(_onRegisterUser);
    on<LogInUser>(_onLogInUser);
    on<LogOutUser>(_onLogOutUser);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserCredential users =
          await authRepository.registerUserWithEmailAndPassword(
        event.payload,
      );
      emit(AuthAuthenticated());
      if (event.context.mounted) {
        Navigator.pushNamed(
          event.context,
          home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (event.context.mounted) {
        if (e.code == 'weak-password') {
          showSnackBar(event.context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(event.context, 'The account already exists for that email.');
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogInUser(LogInUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserCredential users = await authRepository.logInUserWithEmailAndPassword(
          event.payload);
      
      emit(AuthAuthenticated());
      if (event.context.mounted) {
        Navigator.pushNamed(
          event.context,
          home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (event.context.mounted) {
        if (e.code == 'user-not-found') {
          showSnackBar(event.context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSnackBar(event.context, 'Wrong password provided for that user.');
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogOutUser(LogOutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
