import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:g3_interactive_task/features/auth/presentation/widgets/text_field.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/pages/personnel_list_screen.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_snackbar.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> obscurePassword = ValueNotifier(true);

  // bool obscurePassword = true;

  @override
  void initState() {
    isRememberUser();
    super.initState();
  }

  Future<void> isRememberUser() async {
    final email = await SharedPrefsData.getEmail();
    if (email != null && email.isNotEmpty) {
      _emailController.text = email;
      rememberMe.value = true;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: sl<AuthBloc>(),
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return PersonnelListScreen();
            }), (Route<dynamic> route) => false);
          } else if (state is LoginFailedState) {
            customSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset("assets/auth/login_bg.png"),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sl<SizeHelper>().getWidgetWidth(20)),
                  child: Column(
                    children: [
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(120)),
                      Image.asset(
                        'assets/auth/bee_icon.png',
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(15)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(27),
                        text: "BEE CHEM",
                        textColor: Colors.black,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(100)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(26),
                        text: "Welcome Back!",
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(5)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(14),
                        text: "Login to your account",
                        textColor: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(40)),
                      customTextField(
                        controller: _emailController,
                        hintText: "Email address",
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(16)),
                      ListenableBuilder(
                          listenable: obscurePassword,
                          builder: (context, child) {
                            return customTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              icon: Icons.lock_outline,
                              obscure: obscurePassword.value,
                              onToggle: () => obscurePassword.value =
                                  !obscurePassword.value,
                            );
                          }),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ListenableBuilder(
                                  listenable: rememberMe,
                                  builder: (context, child) {
                                    return Checkbox(
                                      value: rememberMe.value,
                                      onChanged: (value) =>
                                          rememberMe.value = value ?? false,
                                      activeColor: const Color(0xFFFDD835),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }),
                              CustomText(
                                fontSize: sl<SizeHelper>().getTextSize(14),
                                text: "Remember me",
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: CustomText(
                              fontSize: sl<SizeHelper>().getTextSize(12),
                              text: "FORGOT PASSWORD?",
                              fontWeight: FontWeight.bold,
                              textColor: Color(0xFFFDD835),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      if (state is LoginLoadingState)
                        SizedBox(
                          width: double.infinity,
                          height: sl<SizeHelper>().getWidgetHeight(45),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFDD835),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 3,
                              )),
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          height: sl<SizeHelper>().getWidgetHeight(45),
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailController.text.trim());

                              if (_emailController.text.trim().isEmpty) {
                                customSnackbar(
                                    context, "Please enter your email");
                              } else if (!emailValid) {
                                customSnackbar(context,
                                    "Please enter a valid email address");
                              } else if (_passwordController.text
                                      .trim()
                                      .length <
                                  6) {
                                customSnackbar(context,
                                    "Password cannot be less than 6 characters");
                              } else {
                                sl<AuthBloc>().add(LoginEvent(
                                    isRememberUser: rememberMe.value,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDD835),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 3,
                            ),
                            child: CustomText(
                              fontSize: sl<SizeHelper>().getTextSize(14),
                              text: "LOGIN",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(35)),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          SizedBox(width: sl<SizeHelper>().getWidgetHeight(3)),
                          CustomText(
                            fontSize: sl<SizeHelper>().getTextSize(13),
                            text: "OR",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: sl<SizeHelper>().getWidgetHeight(3)),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(35)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            fontSize: sl<SizeHelper>().getTextSize(13),
                            text: "Don't have an account? ",
                            fontWeight: FontWeight.w500,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: CustomText(
                              fontSize: sl<SizeHelper>().getTextSize(13),
                              text: "REGISTER",
                              textColor: Color(0xFFFDD835),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(40)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
