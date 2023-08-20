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

class GetLocations extends RickAndMortyEvent {
  const GetLocations({required this.page});
  final int page;
}

class GetResidents extends RickAndMortyEvent {
  const GetResidents({required this.locationId});
  final int locationId;
}
