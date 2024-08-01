import 'package:firebase_auth/firebase_auth.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/providers/auth_provider.dart';
import 'package:morningstar/data/repositories/storage.dart';

class AuthRepository {
  Future<void> logout() async {
    await SharedPreferenceRepository().clearStorage();
    await FirebaseAuthProvider.instance.signOut();
  }

  Future<UserCredential> registerUserWithEmailAndPassword(
    RegisterModel payload,
  ) async {
    return FirebaseAuthProvider.instance.registerUserWithEmailAndPassword(
      email: payload.email,
      password: payload.password,
    );
  }

  Future<UserCredential> logInUserWithEmailAndPassword(
    LoginModel payload,
  ) async {
    return FirebaseAuthProvider.instance.logInUserWithEmailAndPassword(
      email: payload.email,
      password: payload.password,
    );
  }
}
