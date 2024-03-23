import 'package:baatcheet/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:baatcheet/core/theme/theme.dart';
import 'package:baatcheet/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:baatcheet/features/auth/presentation/pages/login_page.dart';
import 'package:baatcheet/features/home/presentation/bloc/home_bloc.dart';
import 'package:baatcheet/features/home/presentation/pages/home.dart';
import 'package:baatcheet/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBlocBloc>()),
      BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBlocBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Blogs',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return Home();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
