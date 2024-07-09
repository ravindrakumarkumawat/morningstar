import 'package:flutter/material.dart';
import 'package:morningstar/common/loader/loader.dart';
import 'package:morningstar/features/twitter/widgets/tweet_card.dart';

class TweetList extends StatelessWidget {
  // '2024-07-07 07:19:50.776435'
  TweetList({super.key});
  final List<Map<String, dynamic>> tweetList = [
  {
    "id": "1",
    "tweetedAt": "2024-07-01T12:34:56.000Z",
    "avatar": "https://randomuser.me/api/portraits/men/1.jpg",
    "name": "John Doe",
    "username": "@johndoe",
    "text": "Check out this amazing view! #nature",
    "imageLinks": [
      "https://picsum.photos/200",
      "https://picsum.photos/200",
      "https://picsum.photos/200"
    ],
    "tweetType": "image",
    "link": "www.flutteris.com/blog",
    "commentIds": ["1", "2", "3"],
    "reshareCount": 256,
    "likes": ["1", "2", "3"],
    "retweetedBy": "",
    "repliedTo": ""
  },
  {
    "id": "2",
    "tweetedAt": "2024-07-02T13:45:00.000Z",
    "avatar": "https://randomuser.me/api/portraits/women/2.jpg",
    "name": "Jane Smith",
    "username": "@janesmith",
    "text": "Loving the new features in Flutter! #flutterdev",
    "imageLinks": [
      "https://picsum.photos/200",
      "https://picsum.photos/200",
      "https://picsum.photos/200"
    ],
    "tweetType": "image",
    "link": "www.flutteris.com/blog",
    "commentIds": ["4", "5", "6"],
    "reshareCount": 128,
    "likes": ["4", "5", "6"],
    "retweetedBy": "",
    "repliedTo": ""
  },
  {
    "id": "3",
    "tweetedAt": "2024-07-03T14:50:30.000Z",
    "avatar": "https://randomuser.me/api/portraits/men/3.jpg",
    "name": "Mike Johnson",
    "username": "@mikejohnson",
    "text": "Had a great time at the conference! #tech",
    "imageLinks": [
      "https://picsum.photos/200",
      "https://picsum.photos/200",
      "https://picsum.photos/200"
    ],
    "tweetType": "image",
    "link": "www.flutteris.com/blog",
    "commentIds": ["7", "8", "9"],
    "reshareCount": 512,
    "likes": ["7", "8", "9"],
    "retweetedBy": "",
    "repliedTo": ""
  },
  {
    "id": "4",
    "tweetedAt": "2024-07-04T15:55:15.000Z",
    "avatar": "https://randomuser.me/api/portraits/women/4.jpg",
    "name": "Emily Davis",
    "username": "@emilydavis",
    "text": "Exploring the city! #travel",
    "imageLinks": [
      "https://picsum.photos/200",
      "https://picsum.photos/200",
      "https://picsum.photos/200"
    ],
    "tweetType": "image",
    "link": "www.flutteris.com/blog",
    "commentIds": ["10", "11", "12"],
    "reshareCount": 64,
    "likes": ["10", "11", "12"],
    "retweetedBy": "",
    "repliedTo": ""
  },
  {
    "id": "5",
    "tweetedAt": "2024-07-05T16:00:00.000Z",
    "avatar": "https://randomuser.me/api/portraits/men/5.jpg",
    "name": "David Wilson",
    "username": "@davidwilson",
    "text": "Learning Dart and Flutter. #coding",
    "imageLinks": [
      "https://picsum.photos/200",
      "https://picsum.photos/200",
      "https://picsum.photos/200"
    ],
    "tweetType": "image",
    "link": "www.flutteris.com/blog",
    "commentIds": ["13", "14", "15"],
    "reshareCount": 32,
    "likes": ["13", "14", "15"],
    "retweetedBy": "",
    "repliedTo": ""
  }
];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tweetList.isEmpty
          ? const Loader()
          : ListView.builder(
              itemCount: tweetList.length * 10,
              itemBuilder: (context, index) {
                return TweetCard(
                  tweet: tweetList[index % tweetList.length],
                );
              },
            ),
    );
  }
}
