part of 'dependencies.dart';

injectBlocs() {
  //Auth Bloc
  sl.registerSingleton(
    AuthBloc(),
  );

  //Personnel List Bloc
  sl.registerSingleton(
    PersonnelListBloc(),
  );

  //Personnel Form Bloc
  sl.registerSingleton(
    PersonnelFormBloc(),
  );
}
