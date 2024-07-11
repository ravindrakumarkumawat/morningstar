import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningstar/routes/controller/auth_controller.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:morningstar/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authController = Get.put(AuthController());
  await authController.checkAuthStatus();
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
       initialRoute: Get.find<AuthController>().isAuthenticated.value ? home : welcome,
    );
  }
}