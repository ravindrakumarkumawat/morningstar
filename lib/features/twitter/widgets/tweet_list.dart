import 'package:flutter/material.dart';
import 'package:morningstar/common/loader/loader.dart';
import 'package:morningstar/features/twitter/widgets/tweet_card.dart';

class TweetList extends StatelessWidget {
  // '2024-07-07 07:19:50.776435'
  TweetList({super.key});
  final List<Map<String, dynamic>> tweetList = [
    {
      'tweetedAt': '15 min ago',
      'avatar':
          'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
      'name': 'Vivekanadata',
      'username': '@viveka',
      'text':
          '#ravindra https://twitter.com/ Building Bounce along with Varun, Anil, Building Bounce Building Bounce along with Varun, Anilng with Varun, Anil Building Bounce along with Varun, Anil',
      'imageLink': 'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg', 
      'tweetType': 'image',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tweetList.isEmpty ? const Loader() : ListView.builder(
        itemCount: tweetList.length * 10,
        itemBuilder: (context, index) {
          return TweetCard(
            tweet: tweetList[0],
          );
        },
      ),
    );
  }
}