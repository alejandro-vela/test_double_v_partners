part of 'rick_and_morty_bloc.dart';

sealed class RickAndMortyEvent extends Equatable {
  const RickAndMortyEvent();

  @override
  List<Object> get props => [];
}

class GetCharacters extends RickAndMortyEvent {
  const GetCharacters({required this.page});
  final int page;
}
