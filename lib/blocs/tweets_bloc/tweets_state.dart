import 'package:equatable/equatable.dart';
import 'package:morningstar/data/models/tweet.dart';

abstract class TweetsState extends Equatable {
  const TweetsState();

  @override
  List<Object> get props => [];
}

class TweetsInitialState extends TweetsState {}

class TweetsLoadingState extends TweetsState {}

class TweetsSuccessState extends TweetsState {
  final List<Tweet> tweets;

  const TweetsSuccessState({required this.tweets});

  @override
  List<Object> get props => [tweets];
}

class TweetsFailureState extends TweetsState {
  final String error;

  const TweetsFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
