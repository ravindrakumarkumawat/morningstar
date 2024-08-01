import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/presentation/features/accounts/accounts_list.dart';
import 'package:morningstar/presentation/features/authentication/create_account.dart';
import 'package:morningstar/presentation/features/authentication/views/forgot_password.dart';
import 'package:morningstar/presentation/features/authentication/views/login.dart';
import 'package:morningstar/presentation/features/home/home_view.dart';
import 'package:morningstar/presentation/features/profile/profile.dart';
import 'package:morningstar/presentation/pages/welcome.dart';

const String welcome = '/welcome';
const String login = '/login';
const String register = '/register';
const String home = '/home';
const String followListRecommendation = '/follow-recommendation';
const String forgetPassword = '/forget-password';
const String profilePage = '/profile';

RoutePredicate homePage = ModalRoute.withName(home);

var routes = [
  GetPage(
    name: welcome,
    page: () => Welcome(),
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
  GetPage(
    name: forgetPassword,
    page: () => const ForgetPassword(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: profilePage,
    page: () => const Profile(),
    transition: Transition.downToUp,
  ),
];
