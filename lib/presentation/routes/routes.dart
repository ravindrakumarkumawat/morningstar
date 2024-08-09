import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/presentation/features/accounts/accounts_list.dart';
import 'package:morningstar/presentation/features/authentication/register.dart';
import 'package:morningstar/presentation/features/authentication/forgot_password.dart';
import 'package:morningstar/presentation/features/authentication/login.dart';
import 'package:morningstar/presentation/features/home/home_view.dart';
import 'package:morningstar/presentation/features/profile/profile.dart';
import 'package:morningstar/presentation/features/profile/profile_setup.dart';
import 'package:morningstar/presentation/features/profile/widget/profile_picture_upload.dart';
import 'package:morningstar/presentation/pages/welcome.dart';

const String welcome = '/welcome';
const String login = '/login';
const String register = '/register';
const String home = '/home';
const String followListRecommendation = '/follow-recommendation';
const String forgetPassword = '/forget-password';
const String profilePage = '/profile';
const String profileSetupPage = '/profile-setup';
const String profilePictureUploadPage = '/profile-image-upload';
const String usernamePage = '/username';
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
  GetPage(
    name: profileSetupPage,
    page: () => const ProfileSetupPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: profilePictureUploadPage,
    page: () => const ProfilePictureUpload(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: usernamePage,
    page: () => const ProfilePictureUpload(),
    transition: Transition.leftToRight,
  ),
];
