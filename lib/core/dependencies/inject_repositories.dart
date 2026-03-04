part of 'dependencies.dart';

void injectRepositories() {
  // Auth
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl()),
  );

  // Personnel List
  sl.registerLazySingleton<PersonnelListRepository>(
    () => PersonnelListRepositoryImpl(sl()),
  );
  
  // Personnel Form
  sl.registerLazySingleton<PersonnelFormRepository>(
    () => PersonnelFormRepositoryImpl(sl()),
  );
}
