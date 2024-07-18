import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_bloc.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_state.dart';
import 'package:morningstar/presentation/common/loader/loader.dart';
import 'package:morningstar/presentation/features/twitter/widgets/tweet_card.dart';

class TweetList extends StatelessWidget {
  TweetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TweetBloc, TweetState>(
      builder: (context, state) {
        if (state is TweetLoading) {
          return Loader();
        } else if (state is TweetLoaded) {
          return StreamBuilder<QuerySnapshot>(
            stream: state.tweetStream,
            builder: (context, tweetSnapshot) {
              if (tweetSnapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              } else if (tweetSnapshot.hasError) {
                return Center(child: Text('Error: ${tweetSnapshot.error}'));
              } else if (!tweetSnapshot.hasData ||
                  tweetSnapshot.data!.docs.isEmpty) {
                return Center(child: Text('No tweets available'));
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
        } else if (state is TweetError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }
}
