import 'package:flutter/material.dart';
import 'package:morningstar/common/loader/loader.dart';
import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/repositories/tweets_repository.dart';
import 'package:morningstar/features/twitter/widgets/tweet_card.dart';

class TweetList extends StatefulWidget {
  TweetList({super.key});

  @override
  State<TweetList> createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  List<TweetModel>? tweetList;

  @override
  void initState() {
    super.initState();
    fetchAllTweets();
  }

  Future<void> fetchAllTweets() async {
    try {
      List<TweetModel> allTweets = await TwittesRepository().getAllTweets();
      setState(() {
        tweetList = allTweets;
      });
    } catch (err) {
      print('Error fetching tweets: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tweetList == null
          ? const Loader()
          : ListView.builder(
              itemCount: tweetList?.length ?? 0,
              itemBuilder: (context, index) {
                return TweetCard(
                  key: ValueKey(tweetList?[index].id),
                  tweet: tweetList![index].toMap(), // TODO: ERROR EXIST HERE NEED TO FIX
                );
              },
            ),
    );
  }
}
