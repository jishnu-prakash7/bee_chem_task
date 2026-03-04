import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:g3_interactive_task/features/auth/data/repository/login_repository_impl.dart';
import 'package:g3_interactive_task/features/auth/domain/repository/login_repository.dart';
import 'package:g3_interactive_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:g3_interactive_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:g3_interactive_task/features/personnel_form/data/data_sources/remote/personnel_form_remote_data_source.dart';
import 'package:g3_interactive_task/features/personnel_form/data/repository/personnel_form_repository_impl.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/repository/presonnel_form_repository.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/use_cases/add_personnel_details_use_case.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/use_cases/fetch_role_list_use_case.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/bloc/personnel_form_bloc.dart';
import 'package:g3_interactive_task/features/personnel_list/data/data_sources/remote/personnel_list_remote_data_source.dart';
import 'package:g3_interactive_task/features/personnel_list/data/repository/personnel_list_repository_impl.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/repository/personnel_list_repository.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/use_cases/fetch_personnel_list_use_case.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/bloc/personnel_list_bloc.dart';
import 'package:get_it/get_it.dart';

part 'inject_blocs.dart';
part 'inject_data_sources.dart';
part 'inject_repositories.dart';
part 'inject_use_cases.dart';
part 'inject_size_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json')));

  // Data Sources
  injectDataSources();

  // Repositories
  injectRepositories();

  // Use Cases
  injectUseCases();

  // BLoCs
  injectBlocs();

  //size helper
  setupSizeHelper();
}
