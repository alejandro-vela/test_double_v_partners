part of 'rick_and_morty_bloc.dart';

sealed class RickAndMortyState extends Equatable {
  const RickAndMortyState();

  @override
  List<Object> get props => [];
}

final class RickAndMortyInitial extends RickAndMortyState {}

final class CharactersLoading extends RickAndMortyState {}

final class LocationsLoading extends RickAndMortyState {}

final class CharactersLoaded extends RickAndMortyState {
  const CharactersLoaded();
}

final class LocationsLoaded extends RickAndMortyState {}

final class ResidentsLoading extends RickAndMortyState {}

final class ResidentsLoaded extends RickAndMortyState {
  const ResidentsLoaded({required this.residents});

  final List<ResultModel> residents;
}

final class FinishWithError extends RickAndMortyState {
  const FinishWithError({required this.message});
  final String message;
}

final class FinishWithErrorResident extends RickAndMortyState {
  const FinishWithErrorResident({required this.message});
  final String message;
}
