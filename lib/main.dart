import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/data_layer/data/repositories/auth_repository.dart';
import 'package:morningstar/presentation_layer/features/home/home_view.dart';
import 'package:morningstar/firebase_options.dart';
import 'package:morningstar/presentation_layer/pages/splash.dart';
import 'package:morningstar/presentation_layer/routes/routes.dart';
import 'package:morningstar/presentation_layer/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:morningstar/business_layer/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_layer/blocs/authentication/auth_state.dart';
import 'package:morningstar/business_layer/blocs/authentication/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthRepository authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository)..add(CheckAuthStatus()),
      child: GetMaterialApp(
        theme: AppTheme.theme.copyWith(
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        getPages: routes,
        home: AuthPage(),
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return Splash();
        } else if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          return HomeView();
        } else if (state is AuthUnauthenticated) {
          return Splash();
        } else if (state is AuthError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
