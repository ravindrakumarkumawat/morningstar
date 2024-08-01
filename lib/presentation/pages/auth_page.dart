import 'package:flutter/material.dart';

import 'package:morningstar/presentation/features/home/home_view.dart';
import 'package:morningstar/presentation/pages/splash.dart';
import 'package:morningstar/presentation/pages/welcome.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return Welcome();
        } else if (state is AuthLoading) {
          return const Splash();
        } else if (state is AuthAuthenticated) {
          return const HomeView();
        } else if (state is AuthUnauthenticated) {
          return Welcome();
        } else if (state is AuthError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
