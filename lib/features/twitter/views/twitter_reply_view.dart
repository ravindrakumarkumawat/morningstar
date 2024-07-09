import 'package:flutter/material.dart';
import 'package:morningstar/features/twitter/widgets/tweet_card.dart';
import 'package:morningstar/theme/pallete.dart';

class TwitterReplyScreen extends StatelessWidget {
  static route(Map<String, dynamic> tweet) => MaterialPageRoute(
        builder: (context) => TwitterReplyScreen(
          tweet: tweet,
        ),
      );
  final Map<String, dynamic> tweet; // Todo: modal needs to be created
  TwitterReplyScreen({super.key, required this.tweet});

  final List<Map<String, dynamic>> tweetList = [
    {
      'id': '1',
      'tweetedAt': DateTime.now(),
      'avatar':
          'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
      'name': 'Vivekanadata',
      'username': '@viveka',
      'text':
          '#ravindra https://twitter.com/ Building Bounce along with Varun, Anil, Building Bounce Building Bounce along with Varun, Anilng with Varun, Anil Building Bounce along with Varun, Anil',
      'imageLinks': [
        'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
        'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
        'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
      ],
      'tweetType': 'image',
      'link': 'www.flutteris.com/blog',
      'commentIds': ['1', '2', '3'],
      'reshareCount': 256,
      'likes': ['1', '2', '3'],
      'retweetedBy': '',
    }
  ]; // This will be coming from bloc
  final index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet'),
        backgroundColor: Pallete.whiteColor,
      ),
      body: Column(
        children: [
          TweetCard(tweet: tweet),
            false
              ? Expanded(
                  child: ListView.builder(
                    itemCount: tweetList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tweet = tweetList[index];
                      return TweetCard(tweet: tweet);
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: tweetList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tweet = tweetList[index];
                      return TweetCard(tweet: tweet);
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onSubmitted: (value) {
            // {
            //   images: [],
            //   text: value,
            //   context: context,
            //   repliedTo: tweet.id,
            //   repliedToUserId: tweet.uid,
            // };
          },
          decoration: const InputDecoration(
            hintText: 'Tweet your reply',
          ),
        ),
      ),
    );
  }
}
