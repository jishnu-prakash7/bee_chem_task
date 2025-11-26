
import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/bloc/personnel_form_bloc.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/bloc/personnel_list_bloc.dart';
import 'package:get_it/get_it.dart';

part 'inject_blocs.dart';

part 'inject_size_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await injectBlocs();
  setupSizeHelper();
}
