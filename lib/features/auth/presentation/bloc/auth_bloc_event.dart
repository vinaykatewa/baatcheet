part of 'auth_bloc_bloc.dart';
//naming convention user first bloc name and then event name

@immutable
sealed class AuthBlocEvent {}

final class AuthSignUp extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;
  AuthSignUp({required this.name, required this.email, required this.password});
}

final class AuthLogin extends AuthBlocEvent {
  final String email;
  final String password;
  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthBlocEvent {}
