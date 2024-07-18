import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/providers/auth_provider.dart';
import 'package:morningstar/data/repositories/storage.dart';
import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class AuthRepository {
  Future<void> logout() async {
    await SharedPreferenceRepository().clearStorage();
    await FirebaseAuthProvider.instance.signOut();
  }

  Future<void> registerUserWithEmailAndPassword(
    RegisterModel payload,
    BuildContext context,
  ) async {
    try {
      final credential = await FirebaseAuthProvider.instance
          .registerUserWithEmailAndPassword(
              email: payload.email, password: payload.password);
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
      final credential =
          await FirebaseAuthProvider.instance.logInUserWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );
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
