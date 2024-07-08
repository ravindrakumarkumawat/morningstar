import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSuccessEvent extends AuthenticationEvent {
  final Uri authorizationUrl;
  final Uri redirectUrl;

  const AuthenticationSuccessEvent({
    required this.authorizationUrl,
    required this.redirectUrl,
  });

  @override
  List<Object> get props => [authorizationUrl, redirectUrl];
}
