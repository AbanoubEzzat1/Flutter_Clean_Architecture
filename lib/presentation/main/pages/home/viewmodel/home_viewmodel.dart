// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/home_usecase.dart';
import 'package:flutter_clean_arch_revision2/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannerStreamController =
      BehaviorSubject<List<BannersAdd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Stores>>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  //-- HomeViewModelInput --

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              inputState.add(ErrorState(
                StateRendererType.fullScreenErrorState,
                failure.message,
              )),
            }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data?.bannersAdd);
      inputServices.add(homeObject.data?.services);
      inputStores.add(homeObject.data?.stores);
    });
  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  //output

  @override
  Stream<List<BannersAdd>> get outputBanners =>
      _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Services>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Stores>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInput {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutput {
  Stream<List<Stores>> get outputStores;
  Stream<List<Services>> get outputServices;
  Stream<List<BannersAdd>> get outputBanners;
}
