import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rick_and_morty_event.dart';
part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  RickAndMortyBloc() : super(RickAndMortyInitial()) {
    on<RickAndMortyEvent>((event, emit) {});
    on<GetCharacters>(_getCharacters);
  }

  Future _getCharacters(
    GetCharacters event,
    Emitter<RickAndMortyState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(const CharactersLoaded());
    } catch (e) {
      emit(FinishWithError(message: e.toString()));
    }
  }
}
