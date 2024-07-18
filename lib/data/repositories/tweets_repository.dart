import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/providers/tweets_provider.dart';

class TwittesRepository {
  Future<void> addTweet(TweetModel payload) async {
    await TweetsProvider.instance.addTweet(tweet: payload.toMap());
  }

  Future<Stream<QuerySnapshot<Object?>>> getAllTweets() async {
    return TweetsProvider.instance.getAllTweetsStream();
  }
}
