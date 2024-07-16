import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/presentation_layer/features/home/home_view.dart';
import 'package:morningstar/firebase_options.dart';
import 'package:morningstar/presentation_layer/pages/splash.dart';
import 'package:morningstar/presentation_layer/routes/routes.dart';
import 'package:morningstar/presentation_layer/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.theme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      getPages: routes,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print('Auth data');
            print(snapshot);

            return snapshot.hasData ? HomeView() : Splash();
          }),
    );
  }
}