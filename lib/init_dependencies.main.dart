part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImplementation(supabaseClient: serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(serviceLocator(), serviceLocator()))
    ..registerFactory<UserSignUp>(
        () => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory<UserLogin>(() => UserLogin(repository: serviceLocator()))
    ..registerFactory<CurrentUser>(
        () => CurrentUser(repository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBlocBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator()),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImplementation())
    ..registerFactory<ChatRepository>(() =>
        ChatRepositoryImplementation(homeRemoteDataSource: serviceLocator()))
    ..registerFactory<ChannelsUseCase>(
        () => ChannelsUseCase(chatRepository: serviceLocator()))
        //send message usecase
    ..registerFactory<SendMessage>(() =>
        SendMessage(chatRepository: serviceLocator()))
    ..registerLazySingleton(() => HomeBloc(channelsUseCase: serviceLocator(), sendMessage: serviceLocator()));
}
