part of 'dependencies.dart';

void injectUseCases() {
  // Auth
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );

  // Personnel List
  sl.registerLazySingleton<FetchPersonnelListUseCase>(
    () => FetchPersonnelListUseCase(sl()),
  );

  // Role List - Personnel form
  sl.registerLazySingleton<FetchRoleListUseCase>(
    () => FetchRoleListUseCase(sl()),
  );

  // Add Personnel Details - Personnel form
  sl.registerLazySingleton<AddPersonnelDetailsUseCase>(
    () => AddPersonnelDetailsUseCase(sl()),
  );
}
