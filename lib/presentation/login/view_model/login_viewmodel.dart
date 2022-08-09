import 'dart:async';

import 'package:flutter_clean_arch_revision2/domain/usecase/login_usecase.dart';
import 'package:flutter_clean_arch_revision2/presentation/base/base_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/freezed_data_class.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInpouts, LoginViewModelOutpouts {
  final StreamController _usserNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    super.dispose();
    _usserNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //-- Login ViewModel Inputs
  @override
  Sink get inputareAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _usserNameStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                    StateRendererType.poupErrorState,
                    failure.message,
                  ))
                },
            (data) => {
                  inputState.add(ContentState()),
                  isUserLoggedInSuccessfullyStreamController.add(true),
                });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputareAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputareAllInputsValid.add(null);
  }

  //-- Login ViewModel Outputs
  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllinputsValid());

  @override
  Stream<bool> get outIsPassword => _passwordStreamController.stream
      .map((isPasswordVaild) => _isPasswordVaild(isPasswordVaild));

  @override
  Stream<bool> get outIsUserName => _usserNameStreamController.stream
      .map((isUserNameValid) => _isUserNameValid(isUserNameValid));

  //-- Login ViewModel Private Functions
  bool _isPasswordVaild(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllinputsValid() {
    return _isPasswordVaild(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInpouts {
  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputareAllInputsValid;
}

abstract class LoginViewModelOutpouts {
  Stream<bool> get outIsUserName;
  Stream<bool> get outIsPassword;
  Stream<bool> get outAreAllInputsValid;
}
