import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/auth/presentation/pages/auth_screen.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/pages/personnel_list_screen.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      validate();
    });
    super.initState();
  } 

  validate() async {
    final rememberUser = await SharedPrefsData.isRememberUser();
    if (!mounted) return;
    if (rememberUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PersonnelListScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          fontSize: sl<SizeHelper>().getTextSize(23),
          text: "BEE CHEM",
          fontWeight: FontWeight.w900,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
