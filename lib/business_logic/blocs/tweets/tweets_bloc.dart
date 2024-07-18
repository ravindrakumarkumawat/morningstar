import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_event.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_state.dart';
import 'package:morningstar/data/repositories/tweets_repository.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final tweetRepository = TwittesRepository();

  TweetBloc() : super(TweetInitial()) {
    on<FetchTweets>(_onFetchTweets);
  }

  Future<void> _onFetchTweets(
      FetchTweets event, Emitter<TweetState> emit) async {
    emit(TweetLoading());
    try {
      final tweetStream = await tweetRepository.getAllTweets();
      emit(TweetLoaded(tweetStream));
    } catch (e) {
      emit(TweetError(e.toString()));
    }
  }
}
