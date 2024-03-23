import 'package:baatcheet/core/common/widgets/loader.dart';
import 'package:baatcheet/core/theme/app_pallete.dart';
import 'package:baatcheet/core/utils/show_snackbar.dart';
import 'package:baatcheet/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:baatcheet/features/auth/presentation/pages/signup_page.dart';
import 'package:baatcheet/features/auth/presentation/widgets/auth_field.dart';
import 'package:baatcheet/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
            // else if (state is AuthSuccess) {
            //   showSnackBar(context, 'Successfully logged in');
            // }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            } 
            else {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        isPasswordText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthGradientButton(
                          text: 'Login',
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              context.read<AuthBlocBloc>().add(AuthLogin(
                                    email:
                                        emailController.text.trim().toLowerCase(),
                                    password: passwordController.text.trim(),
                                  ));
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, SignUpPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: AppPalette.gradient2,
                                          fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                              ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
