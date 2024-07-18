import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TweetState {}

class TweetInitial extends TweetState {}

class TweetLoading extends TweetState {}

class TweetLoaded extends TweetState {
  final Stream<QuerySnapshot<Object?>> tweetStream;

  TweetLoaded(this.tweetStream);
}

class TweetError extends TweetState {
  final String error;

  TweetError(this.error);
}

