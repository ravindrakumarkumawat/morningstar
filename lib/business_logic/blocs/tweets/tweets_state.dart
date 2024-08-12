import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TweetsState {}

class TweetsInitial extends TweetsState {}

class TweetsLoading extends TweetsState {}

class TweetsLoaded extends TweetsState {
  final Stream<QuerySnapshot<Object?>> tweetStream;

  TweetsLoaded(this.tweetStream);
}

class TweetsError extends TweetsState {
  final String error;

  TweetsError(this.error);
}

