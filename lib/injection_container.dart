import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ramft/features/characters/data/datasources/characters_data_source.dart';
import 'package:ramft/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:ramft/features/characters/domain/repositories/characters_repository.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:ramft/features/characters/presentation/blocs/characters_bloc.dart';

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
    CharactersRepositoryImpl(dataSource: sl())
  );

  // Data source
  sl.registerLazySingleton<CharactersDataSource>(() =>
      CharactersDataSourceImpl(client: sl())
  );
}

void initCore() {
  // Core
}

Future<void> initExternal() async {
  sl.registerLazySingleton(() => http.Client());
}