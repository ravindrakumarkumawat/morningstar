import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/blocs/tweets_bloc/tweets_event.dart';
import 'package:morningstar/blocs/tweets_bloc/tweets_state.dart';
import 'package:morningstar/repositories/twitter_repository.dart';

class TweetsBloc extends Bloc<TweetsEvent, TweetsState> {
  final TwitterRepository twitterRepository;
  TweetsBloc({required this.twitterRepository}) : super(TweetsInitialState());

  Stream<TweetsState> mapEventToState(TweetsEvent event) async* {
    if (event is FetchTweets) {
      yield TweetsLoadingState();

      try {
        final tweets = await twitterRepository.fetchTweets();
        yield TweetsSuccessState(tweets: tweets);
      } catch (error) {
        yield TweetsFailureState(error: error.toString());
      }
    }
  }
}
