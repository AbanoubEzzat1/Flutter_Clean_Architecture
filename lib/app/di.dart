import 'package:dio/dio.dart';
import 'package:flutter_clean_arch_revision2/app/app_prefs.dart';
import 'package:flutter_clean_arch_revision2/data/data_source/local_data_source.dart';
import 'package:flutter_clean_arch_revision2/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_arch_revision2/data/network/app_api.dart';
import 'package:flutter_clean_arch_revision2/data/network/dio_factory.dart';
import 'package:flutter_clean_arch_revision2/data/network/network_info.dart';
import 'package:flutter_clean_arch_revision2/data/repository/repository_impl.dart';
import 'package:flutter_clean_arch_revision2/domain/repository/repository.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/forget_password_usecase.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/home_usecase.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/login_usecase.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/register_usecase.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/store_details_usecase.dart';
import 'package:flutter_clean_arch_revision2/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/login/view_model/Login_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/store_details/store_details_viewmodel/store_details_viewmodel.dart';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module whare we put all generic di for all project

  //SharedPreferences instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //AppPreferences instance
  instance
      .registerLazySingleton<AppPreference>(() => AppPreference(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();

  //appServiseClient
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remoteDataSourse
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // LocatDataScorce
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initloginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgetPassword() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}
