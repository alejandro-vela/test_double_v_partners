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
  const GetResidents({
    this.locationId,
    this.episodeId,
  });
  final int? locationId;
  final int? episodeId;
}

class GetEpisodes extends RickAndMortyEvent {
  const GetEpisodes({this.page});
  final int? page;
}
