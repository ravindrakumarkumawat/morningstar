import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morningstar/data/providers/users_provider.dart';

class UsersRepository {
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserByIdStream({required String uuid}) async {
    return UsersProvider.instance.getUserDocRef(uuid).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById({required String uuid}) async {
    return UsersProvider.instance.getUserDocRef(uuid).get();
  }
}
