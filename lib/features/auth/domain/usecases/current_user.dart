import 'package:baatcheet/core/error/failures.dart';
import 'package:baatcheet/core/usecase/usecase.dart';
import 'package:baatcheet/core/common/entities/user.dart';
import 'package:baatcheet/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;

  CurrentUser({required this.repository});
  @override
  Future<Either<Failure, User>> callMethod(NoParams params) async {
    return await repository.currentUser();
  }
}
