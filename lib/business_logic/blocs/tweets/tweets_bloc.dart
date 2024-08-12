import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_event.dart';
import 'package:morningstar/business_logic/blocs/tweets/tweets_state.dart';
import 'package:morningstar/data/repositories/tweets_repository.dart';

class TweetsBloc extends Bloc<TweetsEvent, TweetsState> {
  final tweetRepository = TwittesRepository();

  TweetsBloc() : super(TweetsInitial()) {
    on<FetchTweets>(_onFetchTweets);
  }

  Future<void> _onFetchTweets(
      FetchTweets event, Emitter<TweetsState> emit) async {
    emit(TweetsLoading());
    try {
      final tweetStream = await tweetRepository.getAllTweets();
      emit(TweetsLoaded(tweetStream));
    } catch (e) {
      emit(TweetsError(e.toString()));
    }
  }
}
