import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BEE CHEM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        );
        sl<SizeHelper>().kHeight = data.size.height;
        sl<SizeHelper>().kWidth = data.size.width;
        sl<SizeHelper>().kTextScaler = data.textScaler;
        return MediaQuery(data: data, child: child!);
      },
      home: SplashScreen(),
    );
  }
}
