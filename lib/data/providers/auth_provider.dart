import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class FirebaseAuthProvider {
  FirebaseAuthProvider._privateConstructor();

  static final FirebaseAuthProvider _instance =
      FirebaseAuthProvider._privateConstructor();

  static FirebaseAuthProvider get instance => _instance;

  Future<UserCredential> registerUserWithEmailAndPassword(
      {required String email, required String password }) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> logInUserWithEmailAndPassword(
      {required String email, required String password }) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> forgetPassword(String email,
      {required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        showSnackBar(context,
            'A reset password link is sent yo your mail.You can reset your password from there');
      }).catchError((error) {
        // cprint(error.message);
      });
    } catch (error) {
      showSnackBar(context, error.toString());
      return Future.value(false);
    }
  }
}
