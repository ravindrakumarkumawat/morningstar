import 'package:cloud_firestore/cloud_firestore.dart';

class UsersProvider {
  UsersProvider._privateConstructor();

  static final UsersProvider _instance = UsersProvider._privateConstructor();

  static UsersProvider get instance => _instance;

  final String collection = 'users';

  Future<void> createUser({
    required String uuid,
    required Map<String, dynamic> user,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uuid).set(user);
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUser({
    required String uuid
  }) async {
    return FirebaseFirestore.instance.collection(collection).doc(uuid).snapshots();
  }
}
