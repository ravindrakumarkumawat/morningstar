import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/blocs/authentication_bloc/authentication_event.dart';
import 'package:morningstar/blocs/authentication_bloc/authentication_state.dart';
import 'package:morningstar/data/repositories/twitter_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final TwitterRepository twitterRepository;
  AuthenticationBloc({required this.twitterRepository})
      : super(AuthenticationInitialState());

  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationSuccessEvent) {
      yield AuthenticationLoadingState();
      try {
        await twitterRepository.authenticate(
            event.authorizationUrl, event.redirectUrl);
        yield AuthenticationSuccessState();
      } catch (e) {
        yield AuthenticationFailureState(error: e.toString());
      }
    }
  }
}
