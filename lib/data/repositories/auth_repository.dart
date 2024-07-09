import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:morningstar/data/models/authentication/register.dart';
import 'package:morningstar/data/repositories/storage.dart';
import 'package:morningstar/features/authentication/login.dart';
import 'package:morningstar/mock/authentication/registered_users.json'
    as all_users;

class AuthRepository {
  Future<void> getAllUsers() async {
    try {
      
      await Storage.instance.saveToStorage('allUsers', [] as String);
      Map<String, String> allUsers =
          await Storage.instance.getFromStorage('allUsers');
    } catch (err) {}
  }

  Future<void> authenticate(Register paylod) async {}

  Future<void> login(Login payload) async {}
}
