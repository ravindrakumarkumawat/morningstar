// import 'package:morningstar/model/link_media_info.dart';
import 'dart:convert';
// import 'package:morningstar/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  SharedPreferenceRepository._internal();
  static final SharedPreferenceRepository _singleton =
      SharedPreferenceRepository._internal();

  factory SharedPreferenceRepository() {
    return _singleton;
  }

  Future clearPreferenceValues() async {
    (await SharedPreferences.getInstance()).clear();
  }

  Future<void> saveToStorage(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getFromStorage(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(key);
    return jsonString;
  }
}
