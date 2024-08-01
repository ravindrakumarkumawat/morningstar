import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morningstar/data/providers/users_provider.dart';

class UsersRepository {
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserById({required String uuid}) async {
    return UsersProvider.instance.getUser(uuid: uuid);
  }
}
