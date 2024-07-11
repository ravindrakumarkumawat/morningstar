import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/routes/controller/auth_controller.dart';
import 'package:morningstar/routes/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    return authController.isAuthenticated.value ? null : RouteSettings(name: welcome);
  }
}
