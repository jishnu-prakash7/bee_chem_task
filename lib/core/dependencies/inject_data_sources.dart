part of 'dependencies.dart';

void injectDataSources() {
  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl()));

  // Personnel List
  sl.registerLazySingleton<PersonnelListRemoteDataSource>(
    () => PersonnelListRemoteDataSource(sl()),
  );

  // Personnel Form
  sl.registerLazySingleton<PersonnelFormRemoteDataSource>(
    () => PersonnelFormRemoteDataSource(sl()),
  );
}
