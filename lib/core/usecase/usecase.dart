import 'package:baatcheet/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> callMethod(Params params);
}

class NoParams {}
