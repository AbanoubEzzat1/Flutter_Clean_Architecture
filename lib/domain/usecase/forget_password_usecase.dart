import 'package:flutter_clean_arch_revision2/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/base_usecase.dart';

class ForgetPasswordUseCase implements BaseUseCase<String, ForgetPassword> {
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPassword>> execute(String input) async {
    return await _repository.forgetPassword(input);
  }
}
