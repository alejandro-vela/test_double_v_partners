// ignore_for_file: unused_field
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../global_locator.dart';
import '../../ui/characters/charactes.dart';
import 'model/model_characters.dart';
import 'model/model_episodes.dart';
import 'model/model_locations.dart';
import 'repository/character_repository.dart';

part 'rick_and_morty_event.dart';
part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  RickAndMortyBloc() : super(RickAndMortyInitial()) {
    on<RickAndMortyEvent>((event, emit) {});
    on<GetCharacters>(_getCharacters);
    on<GetLocations>(_getLocations);
    on<GetResidents>(_getResidents);
    on<GetEpisodes>(_getEpisodes);
    on<SortCharacters>(_sortCharacters);
    on<SortLocations>(_sortLocations);
    on<SortEpisodes>(_sortEpisodes);
  }
  final _api = global<CharacterRepository>();
  late CharactersModel characters;
  LocationsModel? locations;
  EpisodesModel? episodes;
  late List<NameIndex> charactersNames;
  late List<NameIndex> locationsNames;
  late List<NameIndex> episodesNames;

  Future _getCharacters(
    GetCharacters event,
    Emitter<RickAndMortyState> emit,
  ) async {
    if (event.page == null) {
      emit(CharactersLoading());
    } else {
      emit(CharactersLoadingMore());
    }
    try {
      if (event.page == null) {
        emit(const CharactersLoaded());
        return;
      }
      final response = await _api.getCharacters(event.page ?? 1);
      if (response['statusCode'] == 200) {
        if (event.page == 1) {
          characters = CharactersModel.fromJson(response);
        } else {
          characters.results.addAll(
            CharactersModel.fromJson(response).results,
          );
          characters.info = CharactersModel.fromJson(response).info;
        }

        charactersNames = characters.results
            .asMap()
            .entries
            .map((entry) => NameIndex(name: entry.value.name, id: entry.key))
            .toList();
        emit(const CharactersLoaded());
      } else {
        emit(FinishWithError(message: response['error']));
        return;
      }
    } catch (e) {
      emit(FinishWithError(message: e.toString()));
    }
  }

  Future _getLocations(
    GetLocations event,
    Emitter<RickAndMortyState> emit,
  ) async {
    if (event.page == null) {
      emit(LocationsLoading());
    } else {
      emit(LocationsLoadingMore());
    }
    try {
      if (locations != null && event.page == null) {
        emit(LocationsLoaded());
        return;
      }
      final response = await _api.getLocations(event.page ?? 1);
      if (response['statusCode'] == 200) {
        if (locations != null) {
          locations!.results.addAll(LocationsModel.fromJson(response).results);
          locations!.info = Info.fromJson(response['info']);
        } else {
          locations = LocationsModel.fromJson(response);
        }
        locationsNames = locations!.results
            .asMap()
            .entries
            .map((entry) => NameIndex(name: entry.value.name, id: entry.key))
            .toList();
        emit(LocationsLoaded());
      } else {
        emit(FinishWithError(message: response['error']));
        return;
      }
    } catch (e) {
      emit(FinishWithError(message: e.toString()));
    }
  }

  Future _getResidents(
    GetResidents event,
    Emitter<RickAndMortyState> emit,
  ) async {
    emit(ResidentsLoading());
    final List<ResultModel> response = [];
    try {
      final residents = event.locationId != null
          ? locations!.results[event.locationId!].residents
          : episodes?.results[event.episodeId!].characters;

      for (final String e in residents!.take(8)) {
        final value = await _api.getResident(e.split('/').last);
        response.add(ResultModel.fromJson(value));
      }
      emit(ResidentsLoaded(residents: response));
    } catch (e) {
      emit(FinishWithErrorResident(message: e.toString()));
    }
  }

  Future _getEpisodes(
    GetEpisodes event,
    Emitter<RickAndMortyState> emit,
  ) async {
    if (event.page == null) {
      emit(EpisodesLoading());
    } else {
      emit(EpisodesLoadingMore());
    }
    try {
      if (episodes != null && event.page == null) {
        emit(EpisodesLoaded());
        return;
      }
      final response = await _api.getEpisode(event.page ?? 1);
      if (response['statusCode'] == 200) {
        if (episodes != null) {
          episodes!.results.addAll(EpisodesModel.fromJson(response).results);
          episodes!.info = Info.fromJson(response['info']);
        } else {
          episodes = EpisodesModel.fromJson(response);
        }
        episodesNames = episodes!.results
            .asMap()
            .entries
            .map((entry) => NameIndex(name: entry.value.name, id: entry.key))
            .toList();
        emit(EpisodesLoaded());
      } else {
        emit(FinishWithErrorEpisode(message: response['error']));
        return;
      }
    } catch (e) {
      emit(FinishWithErrorEpisode(message: e.toString()));
    }
  }

  void _sortCharacters(
    SortCharacters event,
    Emitter<RickAndMortyState> emit,
  ) {
    switch (event.type) {
      case SortItem.Name:
        characters.results.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortItem.Gender:
        characters.results.sort((a, b) => a.gender.compareTo(b.gender));
        break;
      case SortItem.Species:
        characters.results.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
    emit(const CharactersLoaded());
  }

  void _sortLocations(
    SortLocations event,
    Emitter<RickAndMortyState> emit,
  ) {
    locations!.results.sort((a, b) => a.name.compareTo(b.name));

    emit(LocationsLoaded());
  }

  void _sortEpisodes(
    SortEpisodes event,
    Emitter<RickAndMortyState> emit,
  ) {
    episodes!.results.sort((a, b) => a.name.compareTo(b.name));

    emit(EpisodesLoaded());
  }
}
