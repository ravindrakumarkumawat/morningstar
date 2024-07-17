import 'package:flutter/material.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  final RegisterModel payload;
  final BuildContext context;

  RegisterUser(this.payload, this.context);
}

class LogInUser extends AuthEvent {
  final LoginModel payload;
  final BuildContext context;

  LogInUser(this.payload, this.context);
}

class LogOutUser extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

