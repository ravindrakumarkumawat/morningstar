import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/common/loader/loader.dart';
import 'package:morningstar/features/twitter/widgets/tweet_card.dart';

class TweetList extends StatelessWidget {
  TweetList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tweets').snapshots(),
      builder: (context, tweetSnapshot) {
        if (tweetSnapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else {
          final tweetDocs = tweetSnapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
          return ListView.builder(
            itemCount: tweetDocs.length,
            itemBuilder: (context, index) {
              return TweetCard(
                key: ValueKey(tweetDocs[index]),
                tweet: tweetDocs[index],
              );
            },
          );
        }
      },
    );
  }
}
