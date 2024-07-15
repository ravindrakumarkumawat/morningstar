import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/features/Authentication/create_account.dart';
import 'package:morningstar/features/accounts/accounts_list.dart';
import 'package:morningstar/features/authentication/views/login.dart';
import 'package:morningstar/features/home/home_view.dart';
import 'package:morningstar/pages/splash.dart';

// class Routes {
//   MaterialPageRoute onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/login':
//         return MaterialPageRoute(
//             builder: (context) => const Login());
//       default:
//         return MaterialPageRoute(
//           builder: (context) => const Splash());
//     }
//   }
// }

const String welcome = '/welcome';
const String login = '/login';
const String register = '/register'; // Create account
const String home = '/home';
const String followListRecommendation = '/follow-recommendation';

RoutePredicate homePage = ModalRoute.withName(home);

var routes = [
  GetPage(
    name: welcome,
    page: () => Splash(),
  ),
  GetPage(
    name: login,
    page: () => const Login(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: register,
    page: () => const CreateAccount(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: home,
    page: () => const HomeView(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: followListRecommendation,
    page: () => AccountsList(),
    transition: Transition.downToUp,
  ),
];
