import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_clean_arch_revision2/data/data_source/local_data_source.dart';
import 'package:flutter_clean_arch_revision2/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_arch_revision2/data/mapper/mapper.dart';
import 'package:flutter_clean_arch_revision2/data/network/error_handler.dart';
import 'package:flutter_clean_arch_revision2/data/network/failure.dart';
import 'package:flutter_clean_arch_revision2/data/network/network_info.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/data/network/rquestes.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override //Repository
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.login(loginRequest); //_remoteDataSource
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
          //convert from AuthenticationResponse To Authentication
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFFAULT));
        }
      } catch (error) {
        return left(ErrorHandeler.handel(error)
            .failure); //sure error from internet (API)
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource
            .register(registerRequest); //_remoteDataSource
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
          //convert from AuthenticationResponse To Authentication
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFFAULT));
        }
      } catch (error) {
        return left(ErrorHandeler.handel(error)
            .failure); //sure error from internet (API)
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.forgetPassword(email); //_remoteDataSource
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
          //convert from AuthenticationResponse To Authentication
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFFAULT));
        }
      } catch (error) {
        return left(ErrorHandeler.handel(error)
            .failure); //sure error from internet (API)
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return right(response.toDomain());
    } catch (catchError) {
      if (await _networkInfo.isConnected) {
        try {
          final response =
              await _remoteDataSource.getHomeData(); //_remoteDataSource
          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveHomeToCache(response);
            return right(response.toDomain());
            //convert from AuthenticationResponse To Authentication
          } else {
            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFFAULT));
          }
        } catch (error) {
          return left(ErrorHandeler.handel(error)
              .failure); //sure error from internet (API)
        }
      } else {
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getStoreDetails(); //_remoteDataSource
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
          //convert from AuthenticationResponse To Authentication
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFFAULT));
        }
      } catch (error) {
        return left(ErrorHandeler.handel(error)
            .failure); //sure error from internet (API)
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
