import 'package:flutter_clean_arch_revision2/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/data/network/rquestes.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInputs, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInputs input) async {
    return await _repository.register(RegisterRequest(
      input.userName,
      input.countryMobileCode,
      input.mobileNumber,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInputs {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInputs(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
