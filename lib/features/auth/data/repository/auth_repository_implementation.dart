import 'package:baatcheet/core/error/exceptions.dart';
import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/core/network/connection_checker.dart';
import 'package:baatcheet/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:baatcheet/core/common/entities/user.dart';
import 'package:baatcheet/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImplementation(
      this.authRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(authRemoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(authRemoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> fn) async {
    try {
      final user = await fn;
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      // if (!await (connectionChecker.isConnected)) {
      //   final session = authRemoteDataSource.currentUserSession;

      //   if (session == null) {
      //     return left(Failure('User not logged in!'));
      //   }

      //   return right(
      //     UserModel(
      //       id: session.user.id,
      //       email: session.user.email ?? '',
      //       name: '',
      //     ),
      //   );
      // }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
