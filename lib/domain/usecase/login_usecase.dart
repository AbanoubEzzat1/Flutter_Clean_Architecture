import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/data/network/failure.dart';
import 'package:flutter_clean_arch_revision2/data/network/rquestes.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
