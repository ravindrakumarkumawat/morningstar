import 'package:cloud_firestore/cloud_firestore.dart';

class UsersProvider {
  UsersProvider._privateConstructor();

  static final UsersProvider _instance = UsersProvider._privateConstructor();

  static UsersProvider get instance => _instance;

  final String collection = 'users';

  DocumentReference<Map<String, dynamic>> getUserDocRef(String uuid) {
    return FirebaseFirestore.instance.collection(collection).doc(uuid);
  }

  Future<void> createUser({
    required String uuid,
    required Map<String, dynamic> user,
  }) async {
    await getUserDocRef(uuid).set(user);
  }
}
