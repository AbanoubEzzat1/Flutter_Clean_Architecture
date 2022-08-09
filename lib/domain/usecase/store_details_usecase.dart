import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
