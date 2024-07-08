import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/blocs/tweets_bloc/tweets_bloc.dart';
import 'package:morningstar/blocs/tweets_bloc/tweets_event.dart';
import 'package:morningstar/blocs/tweets_bloc/tweets_state.dart';

class TweetsScreen extends StatelessWidget {
  const TweetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Twitter Timeline')),
      body: BlocBuilder<TweetsBloc, TweetsState>(
        builder: (context, state) {
          if (state is TweetsInitialState) {
            return Center(child: Text('Welcome! Fetch tweets to get started.'));
          } else if (state is TweetsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TweetsSuccessState) {
            return ListView.builder(
              itemCount: state.tweets.length,
              itemBuilder: (context, index) {
                final tweet = state.tweets[index];
                return ListTile(
                  title: Text(tweet.username),
                  subtitle: Text(tweet.text),
                );
              },
            );
          } else if (state is TweetsFailureState) {
            return Center(child: Text('Failed to fetch tweets: ${state.error}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<TweetsBloc>(context).add(FetchTweets());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
