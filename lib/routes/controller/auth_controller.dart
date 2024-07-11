import 'package:get/get.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuthenticated.value = prefs.getBool('isAuthenticated') ?? false;
    // if (isAuthenticated.value) {
    //   Get.offAllNamed(home);
    // } else {
    //   Get.offAllNamed(welcome);
    // }
  }

  Future<void> loginController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', true);
    isAuthenticated.value = true;
    Get.offNamed(home);
  }

  Future<void> logoutController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isAuthenticated');
    isAuthenticated.value = false;
    Get.offNamed(welcome);
  }
}
