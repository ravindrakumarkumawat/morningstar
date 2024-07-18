import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_bloc.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_event.dart';
import 'package:morningstar/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/theme/app_theme.dart';
import 'package:morningstar/presentation/pages/auth_page.dart';

import 'package:morningstar/business_logic/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
        BlocProvider(
          create: (context) => TweetBloc()..add(FetchTweets()),
        ),
      ],
      child: GetMaterialApp(
        theme: AppTheme.theme.copyWith(
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        getPages: routes,
        home: const AuthPage(),
      ),
    );
  }
}
