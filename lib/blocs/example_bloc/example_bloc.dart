import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/blocs/example_bloc/example_event.dart';
import 'package:morningstar/blocs/example_bloc/example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleInitialState()) {
    on<ExampleStartEvent>(onExampleStart);
    on<ExampleEndEvent>(onExampleEnd);
  }

  void onExampleStart(ExampleStartEvent event, Emitter<ExampleState> emit) {
    emit(ExampleStartState());
  }

  void onExampleEnd(ExampleEndEvent event, Emitter<ExampleState> emit) {
    emit(ExampleEndState());
  }
}
