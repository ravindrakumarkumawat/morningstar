import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  FirebaseAuthProvider._privateConstructor();

  static final FirebaseAuthProvider _instance =
      FirebaseAuthProvider._privateConstructor();

  static FirebaseAuthProvider get instance => _instance;

  Future<UserCredential> registerUserWithEmailAndPassword(
      {required String email, required String password }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> logInUserWithEmailAndPassword(
      {required String email, required String password }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
