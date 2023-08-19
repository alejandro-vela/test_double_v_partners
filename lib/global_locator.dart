import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'src/api/api_repository.dart';

late GetIt global;

void setupGlobalLocator() {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
}
