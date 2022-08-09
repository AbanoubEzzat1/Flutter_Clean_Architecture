import 'dart:async';
import 'dart:io';

import 'package:flutter_clean_arch_revision2/domain/usecase/register_usecase.dart';
import 'package:flutter_clean_arch_revision2/presentation/base/base_viewmodel.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/freezed_data_class.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/strings_manager.dart';

import '../../../app/functions.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController areAllInpitsvalidtreamController =
      StreamController<void>.broadcast();

  StreamController isRegisterScreenSuccessfullySamController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "", "");
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  // -- RegisterViewModelInputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    areAllInpitsvalidtreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputAllInputsValid => areAllInpitsvalidtreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.poupLoadingState,
      ),
    );
    (await _registerUseCase.execute(RegisterUseCaseInputs(
      registerObject.userName,
      registerObject.countryMobileCode,
      registerObject.mobileNumber,
      registerObject.email,
      registerObject.password,
      registerObject.profilePicture,
    )))
        .fold(
            (failure) => {
                  inputState.add(
                    ErrorState(
                        StateRendererType.poupErrorState, failure.message),
                  )
                }, (data) {
      inputState.add(ContentState());
      //navigate to main screen
      isRegisterScreenSuccessfullySamController.add(true);
    });
  }

  @override
  setContryCode(String contryCode) {
    if (contryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: contryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  // -- RegisterViewModelOutputs
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
        (isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail,
      );

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map(
        (isMobileNumberValid) =>
            isMobileNumberValid ? null : AppStrings.mobilenumberInvalid,
      );

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
        (isPasswordValid) =>
            isPasswordValid ? null : AppStrings.passwordInvalid,
      );

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
        (isUserNameValid) => isUserNameValid ? null : AppStrings.usernameError,
      );

  @override
  Stream<File> get outputIsProfilePicture =>
      _profilePictureStreamController.stream.map(
        (profilePicture) => profilePicture,
      );

  @override
  Stream<bool> get outputIsAllInputsValid =>
      areAllInpitsvalidtreamController.stream.map((_) => _areAllInputsValid());

  // -- RegisterViewModel Private Function
  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
  setUserName(String userName);
  setContryCode(String contryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  register();
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePicture;
  Stream<bool> get outputIsAllInputsValid;
}
