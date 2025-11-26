part of 'dependencies.dart';

injectBlocs() {
  sl.registerSingleton(AuthBloc());
  sl.registerSingleton(PersonnelListBloc());
  sl.registerSingleton(PersonnelFormBloc());
}
  