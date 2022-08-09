// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_revision2/app/app_prefs.dart';
import 'package:flutter_clean_arch_revision2/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATIO_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreference _appPreference;
  DioFactory(this._appPreference);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreference.getAppLanguage();
    Map<String, dynamic> headers = {
      ACCEPT: APPLICATIO_JSON,
      CONTENT_TYPE: APPLICATIO_JSON,
      AUTHORIZATION: Constants.token,
      DEFFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      connectTimeout: Constants.apiTimeOut,
      receiveTimeout: Constants.apiTimeOut,
    );
    if (!kReleaseMode) {
      //!kReleaseMode mean print or use in debug mode only
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
