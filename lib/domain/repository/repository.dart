import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/data/network/failure.dart';
import 'package:flutter_clean_arch_revision2/data/network/rquestes.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, ForgetPassword>> forgetPassword(String email);
  Future<Either<Failure, HomeObject>> getHomeData();
  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
