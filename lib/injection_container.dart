import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ramft/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:ramft/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:ramft/features/characters/domain/repositories/characters_repository.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:ramft/features/characters/presentation/blocs/characters_bloc.dart';

import 'core/database/database.dart';
import 'features/characters/data/datasources/characters_local_data_source.dart';

// Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  initFeatures();

  initCore();

  await initExternal();
}

void initFeatures() {
  // Bloc
  sl.registerFactory(() =>
    CharactersBloc(
      charactersUseCase: sl(),
    )
  );

  // Use cases
  sl.registerLazySingleton(() => GetCharactersUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CharactersRepository>(() =>
    CharactersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()
    )
  );

  // Data source
  sl.registerLazySingleton<CharactersRemoteDataSource>(() =>
      CharactersRemoteDataSourceImpl(client: sl())
  );
  sl.registerLazySingleton<CharactersLocalDataSource>(() =>
      CharactersLocalDataSourceImpl(database: sl())
  );
}

void initCore() {
  // Core
}

Future<void> initExternal() async {
  // Http client
  sl.registerLazySingleton(() => http.Client());

  // Network info
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Database
  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerFactory(() => appDatabase);
}