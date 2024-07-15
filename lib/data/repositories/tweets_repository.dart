import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:morningstar/data/mock/tweets/all_tweets.dart';
import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/repositories/storage.dart';

class TwittesRepository {
  Future<void> getAllUsersTweets() async {
    
  }
  Future<List<TweetModel>> getAllTweets() async {
    String? allTweetsString =
        await SharedPreferenceRepository().getFromStorage('alltweets');

    if (allTweetsString != null && allTweetsString.isNotEmpty) {
      List<dynamic> storageAllTweets = jsonDecode(allTweetsString);

      List<TweetModel> formattedTweets = storageAllTweets.map((tweet) {
        return TweetModel.fromMap(tweet as Map<String, dynamic>);
      }).toList();

      return formattedTweets;
    } else {
      // Use constant data as fallback
      List<TweetModel> formattedTweets = allTweets.map((tweet) {
        return TweetModel.fromMap(tweet);
      }).toList();

      // Optionally save to storage
      await SharedPreferenceRepository()
          .saveToStorage('alltweets', jsonEncode(allTweets));

      return formattedTweets;
    }
  }

  Future<void> addTweet(TweetModel payload) async {
    print('addTweet');
    print(payload);
    await FirebaseFirestore.instance.collection('tweets').add(payload.toMap());
  }

  Future<void> replyTweet() async {}

  Future<void> reTweet() async {}

  Future<void> update(field, newFieldvalue) async {
    await FirebaseFirestore.instance
        .collection('pets')
        .doc('tom')
        .update({field: newFieldvalue});
  }

  // Future<void> delete() async {
  //   await FirebaseFirestore.instance.collection('pets').doc('tom').delete();
  // }
}
