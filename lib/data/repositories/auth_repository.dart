import 'dart:io';
import 'dart:convert';
import 'package:morningstar/data/models/authentication/register.dart';
import 'package:morningstar/data/models/authentication/register_list.dart';
import 'package:morningstar/data/models/authentication/login.dart';
import 'package:morningstar/data/mock/authentication/registered_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  
  Future<void> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> mapUsers = registeredUsers;
    String jsonString = jsonEncode(mapUsers);
    // final da = await Storage.instance.getFromStorage('allusers');
    // return jsonEncode(registeredUsers);
    
    // print(da);
  }

  Future<void> authenticate(Register paylod) async {}

  Future<void> login(Login payload) async {}
}
