import 'package:baatcheet/core/common/widgets/loader.dart';
import 'package:baatcheet/core/theme/app_pallete.dart';
import 'package:baatcheet/core/utils/show_snackbar.dart';
import 'package:baatcheet/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:baatcheet/features/auth/presentation/pages/login_page.dart';
import 'package:baatcheet/features/auth/presentation/widgets/auth_field.dart';
import 'package:baatcheet/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 60),
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
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
                          'Sign up.',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthField(hintText: 'Name', controller: nameController),
                        const SizedBox(
                          height: 15,
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
                          text: 'Sign up',
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              context.read<AuthBlocBloc>().add(AuthSignUp(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim().toLowerCase(),
                                    password: passwordController.text.trim(),
                                  ));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, LoginPage.route());
                          },
                          child: RichText(
                            text: TextSpan(
                                text: 'Already have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
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
