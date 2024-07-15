import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';
import 'package:morningstar/data/models/authentication/register_list.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/mock/authentication/registered_users.dart';
import 'package:morningstar/data/repositories/storage.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:morningstar/utils/utils.dart';

class AuthRepository {
  Future<bool?> checkAuthStatus() async {
    bool? isAuthenticated = await SharedPreferenceRepository()
        .getFromStorageAsBoolean('isAuthenticated');
    return isAuthenticated;
  }

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

  Future<void> authenticate(RegisterModel payload) async {
    List<Map<String, String>> allusers = await AuthRepository().getAllUsers();
    Map<String, String>? currUser;

    allusers.forEach((user) {
      if (user['email'] == payload.email) {
        currUser = user;
      }
    });

    if (currUser == null) {
      // TODO: SAVE THE USER INTO LOCAL STORAGE
      final Map<String, String> curruser = {
        "id": '970657${(allusers.length * 2)}',
        "uid": '970657${(allusers.length * 2)}',
        "name": payload.name,
        "username": payload.username,
        "email": payload.email,
        "mobile": "7338767777",
        "country": "India",
        "countryCode": "In",
        "password": payload.password
      };

      allusers.add(curruser);

      await SharedPreferenceRepository()
          .saveToStorage('allusers', jsonEncode(allusers));
      await SharedPreferenceRepository()
          .saveToStorage('curruser', jsonEncode(curruser));
      await SharedPreferenceRepository()
          .saveToStorageAsBoolean('isAuthenticated', true);

      print('authentication');
      print(allusers);
    } else {
      // TODO Handle user exists or other test cases
    }
  }

  Future<void> login(LoginModel payload) async {
    List<Map<String, String>> allusers = await AuthRepository().getAllUsers();
    Map<String, String>? currUser;

    allusers.forEach((user) {
      if (user['email'] == payload.email) {
        currUser = user;
      }
    });

    print(currUser);
    if (currUser != null) {
      await SharedPreferenceRepository()
          .saveToStorage('curruser', jsonEncode(currUser));
      await SharedPreferenceRepository()
          .saveToStorageAsBoolean('isAuthenticated', true);
    }

    String? use = await SharedPreferenceRepository().getFromStorage('curruser');

    if (use != null && use.isNotEmpty) {
      Map<String, dynamic> cur =
          jsonDecode(use); // TODO: NEED TO UPDATE TO Map<String, String>
      print(use);
    }
  }

  Future<void> logout() async {
    await SharedPreferenceRepository().clearStorage();
    await FirebaseAuth.instance.signOut();
  }

  // Firebase Integration
  Future<void> registerUserWithEmailAndPassword(
    RegisterModel payload,
    BuildContext context,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );

      await SharedPreferenceRepository()
          .saveToStorageAsBoolean('isAuthenticated', true);
      print('register credential');
      print(credential);
      if (context.mounted) {
        Navigator.pushNamed(
          context,
          home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == 'weak-password') {
          showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account already exists for that email.');
        }
      }
    } catch (e) {
      print('Register Error:');
      print(e);
    }
  }

  Future<void> logInUserWithEmailAndPassword(
    LoginModel payload,
    BuildContext context,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );
      await SharedPreferenceRepository()
          .saveToStorageAsBoolean('isAuthenticated', true);
      print('login credential');
      print(credential);
      if (context.mounted) {
        Navigator.pushNamed(
          context,
          home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, 'Wrong password provided for that user.');
        }
      }
    } catch (e) {
      print('Login Error:');
      print(e);
    }
  }
}
