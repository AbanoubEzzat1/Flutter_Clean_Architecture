import 'dart:async';

import 'package:flutter_clean_arch_revision2/app/functions.dart';
import 'package:flutter_clean_arch_revision2/domain/usecase/forget_password_usecase.dart';
import 'package:flutter_clean_arch_revision2/presentation/base/base_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController _emailStreamController = StreamController.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController.broadcast();

  String email = "";
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  // -- ForgetPasswordViewModelInputs --
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get areAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  forgetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.poupLoadingState));
    (await _forgetPasswordUseCase.execute(email)).fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.poupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(SuccessState(supportMessage.support));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    validate();
  }

  // -- ForgetPasswordViewModelOutputs --
  @override
  Stream<bool> get areAllOutputValid =>
      _isAllInputValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  Stream<bool> get outputEmail =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  // -- ForgetPasswordViewModel Private Function --
  bool _isAllInputsValid() {
    return isEmailValid(email);
  }

  validate() {
    areAllInputValid.add(null);
  }
}

abstract class ForgetPasswordViewModelInputs {
  setEmail(String email);
  forgetPassword();
  Sink get inputEmail;
  Sink get areAllInputValid;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outputEmail;
  Stream<bool> get areAllOutputValid;
}
