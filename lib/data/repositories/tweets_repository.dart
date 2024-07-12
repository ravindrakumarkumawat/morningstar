import 'dart:convert';
import 'package:morningstar/data/mock/tweets/all_tweets.dart';
import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/repositories/storage.dart';

class TwittesRepository {
Future<List<TweetModel>> getAllTweets() async {
    String? allTweetsString = await SharedPreferenceRepository().getFromStorage('alltweets');

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
      await SharedPreferenceRepository().saveToStorage('alltweets', jsonEncode(allTweets));

      return formattedTweets;
    }
  }

  Future<void> addTweet() async {}

  Future<void> replyTweet() async {}

  Future<void> reTweet() async {}
}
