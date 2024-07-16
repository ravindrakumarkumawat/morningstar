import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/presentation_layer/features/accounts/accounts_list.dart';
import 'package:morningstar/presentation_layer/features/authentication/create_account.dart';
import 'package:morningstar/presentation_layer/features/authentication/views/login.dart';
import 'package:morningstar/presentation_layer/features/home/home_view.dart';
import 'package:morningstar/presentation_layer/pages/welcome.dart';

const String welcome = '/welcome';
const String login = '/login';
const String register = '/register';
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
