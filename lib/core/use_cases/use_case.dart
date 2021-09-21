import 'package:dartz/dartz.dart';
import 'package:videochat_client/core/errors/failure.dart';

abstract class UseCase<ReturnType, ParamsType> {
  Future<Either<Failure, ReturnType>> call(ParamsType params);
}
