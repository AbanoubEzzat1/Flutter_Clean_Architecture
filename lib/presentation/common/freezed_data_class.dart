// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_class.freezed.dart';

@freezed
class LoginObject with _$LoginObject // to declare this class as a freezed class
{
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String userName,
    String countryMobileCode,
    String mobileNumber,
    String email,
    String password,
    String profilePicture,
  ) = _RegisterObject;
}
