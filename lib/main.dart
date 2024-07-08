import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:morningstar/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:morningstar/blocs/tweets_bloc/tweets_bloc.dart';
import 'package:morningstar/pages/splash.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:morningstar/theme/app_theme.dart';
// import 'package:morningstar/repositories/twitter_repository.dart';
// import 'package:morningstar/screens/authentication_screen.dart';
// import 'package:morningstar/screens/tweets_screen.dart';
// import 'package:morningstar/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.theme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //   useMaterial3: true,
      //   primarySwatch: Colors.deepPurple,
      //   floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: Colors.black,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(50),
      //     ),
      //   ),
      // ),
      // home: const Splash(),
       getPages: routes,
       initialRoute: welcome,
    );
  }
}


// void main() {
//   final TwitterRepository twitterRepository = TwitterRepository();
  
//   runApp(MyApp(twitterRepository: twitterRepository));
// }

// class MyApp extends StatelessWidget {
//   final TwitterRepository twitterRepository;

//   MyApp({required this.twitterRepository});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => AuthenticationBloc(twitterRepository: twitterRepository),
//         ),
//         BlocProvider(
//           create: (context) => TweetsBloc(twitterRepository: twitterRepository),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Twitter',
//         routes: {
//           '/': (context) => AuthenticationScreen(),
//           '/tweets': (context) => TweetsScreen(),
//         },
//       ),
//     );
//   }
// }