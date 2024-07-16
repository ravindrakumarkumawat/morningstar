import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morningstar/data_layer/data/models/tweets/tweets_model.dart';

class TwittesRepository {
  Future<void> addTweet(TweetModel payload) async {
    print('addTweet');
    print(payload);
    await FirebaseFirestore.instance.collection('tweets').add(payload.toMap());
  }
}
