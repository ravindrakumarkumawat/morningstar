import 'package:cloud_firestore/cloud_firestore.dart';

class TweetsProvider {
  TweetsProvider._privateConstructor();

  static final TweetsProvider _instance = TweetsProvider._privateConstructor();

  static TweetsProvider get instance => _instance;

  final String collection = 'tweets';

  Future<DocumentReference<Map<String, dynamic>>> addTweet({required Map<String, dynamic> tweet}) async {
    return await FirebaseFirestore.instance.collection(collection).add(tweet);
  }
}
