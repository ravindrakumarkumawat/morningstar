import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/providers/tweets_provider.dart';

class TwittesRepository {
  Future<void> addTweet(TweetModel payload) async {
    await TweetsProvider.instance.addTweet(tweet: payload.toMap());
  }
}
