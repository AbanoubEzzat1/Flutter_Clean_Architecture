import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/data/network/failure.dart';

abstract class BaseUseCase<IN, Out> {
  Future<Either<Failure, Out>> execute(IN input);
}
