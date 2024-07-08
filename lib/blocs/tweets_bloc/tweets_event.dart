import 'package:equatable/equatable.dart';

abstract class TweetsEvent extends Equatable {
  const TweetsEvent();

  @override
  List<Object> get props => [];
}

class FetchTweets extends TweetsEvent {}
