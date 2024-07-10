import 'dart:io';
import 'dart:convert';
import 'package:morningstar/data/models/authentication/register.dart';
import 'package:morningstar/data/models/authentication/register_list.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/mock/authentication/registered_users.dart';
import 'package:morningstar/data/repositories/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<List<Map<String, String>>> getAllUsers() async {
    String? allusers =
        await SharedPreferenceRepository().getFromStorage('allusers');

    if (allusers != null && allusers.isNotEmpty) {
      List<dynamic> storageusers = jsonDecode(allusers);

      List<Map<String, String>> formattedUser = storageusers.map((usr) {
        Map<String, String> tmp = {
          "id": usr['id'],
          "uid": usr['uid'],
          "name": usr['name'],
          "username": usr['username'],
          "email": usr['email'],
          "mobile": usr['mobile'],
          "country": usr['country'],
          "countryCode": usr['countryCode'],
          "password": usr['password']
        };
        return tmp;
      }).toList();

      return formattedUser; // todo
    } else {
      await SharedPreferenceRepository()
          .saveToStorage('allusers', jsonEncode(registeredUsers));
    }
    return registeredUsers;
  }

  Future<void> authenticate(Register paylod) async {}

  Future<void> login(LoginModel payload) async {
    List<Map<String, String>> allusers = await AuthRepository().getAllUsers();
    Map<String, String>? currUser;

    allusers.forEach((user) {
      if (user['email'] == payload.email) {
        currUser = user;
      }
    });

    print(currUser);
    if(currUser != null) {
      await SharedPreferenceRepository()
        .saveToStorage('curruser', jsonEncode(currUser));
    }
    

    String? use = await SharedPreferenceRepository().getFromStorage('curruser');

    if(use != null && use.isNotEmpty) {
      Map<String, dynamic> cur = jsonDecode(use); // TODO: NEED TO UPDATE TO Map<String, String>
      print(use);
    }
  }
}
