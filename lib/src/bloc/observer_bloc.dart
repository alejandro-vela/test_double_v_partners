import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

/// Encargado de observar los cambios en todos los blocs
class ObserverBloc extends BlocObserver {
  final Logger _logger = Logger();

  /// Cuando ocurre un evento en cualquier bloc
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.d('bloc: ${bloc.runtimeType}, event: $event');
  }

  /// Cuando ocurre una transición de estados en cualquier bloc
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.d('bloc: ${bloc.runtimeType}, transition: $transition');
  }

  /// Cuando ocurre un error en cualquier bloc
  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    _logger
        .d('bloc: ${bloc.runtimeType}, error: $error, stacktrace: $stacktrace');
  }
}
