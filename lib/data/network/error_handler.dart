// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_clean_arch_revision2/data/network/failure.dart';

import 'package:flutter_clean_arch_revision2/presentation/resources/strings_manager.dart';

class ErrorHandeler implements Exception {
  late Failure failure;
  ErrorHandeler.handel(dynamic error) {
    if (error is DioError) {
      failure = _handelError(error);
    } else {
      failure = DataSource.DEFFAULT.getFailure();
    }
  }
}

Failure _handelError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RESIVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response!.statusCode != null &&
          error.response!.statusMessage != null) {
        return Failure(error.response!.statusCode ?? 0,
            error.response!.statusMessage ?? "");
      } else {
        return DataSource.DEFFAULT.getFailure();
      }

    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFFAULT.getFailure();
  }
}

enum DataSource {
  // -- Error / Failure Types --
  SUCCESS,
  NOT_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RESIVE_TIMEOUT,
  SEND_TIMEOUT,
  CASHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFFAULT,
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.NOT_CONTENT:
        return Failure(ResponseCode.NOT_CONTENT, ResponseMessage.NOT_CONTENT);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RESIVE_TIMEOUT:
        return Failure(
            ResponseCode.RESIVE_TIMEOUT, ResponseMessage.RESIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CASHE_ERROR:
        return Failure(ResponseCode.CASHE_ERROR, ResponseMessage.CASHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.DEFFAULT:
        return Failure(ResponseCode.DEFFAULT, ResponseMessage.DEFFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; //Success with data
  static const int NOT_CONTENT = 201; //Success with no data (no-content)
  static const int BAD_REQUEST = 400; //failure API rejected request
  static const int UNAUTORISED = 401; //failure user is not authorised
  static const int FORBIDDEN = 403; //failure API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; //failure crash in server side
  static const int NOT_FOUND = 404; //failure not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RESIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CASHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS = AppStrings.success; //Success with data
  static String NOT_CONTENT =
      AppStrings.success; //Success with no data (no-content)
  static String BAD_REQUEST =
      AppStrings.badRequestError; //failure API rejected request
  static String UNAUTORISED =
      AppStrings.unauthorizedError; //failure user is not authorised
  static String FORBIDDEN =
      AppStrings.forbiddenError; //failure API rejected request
  static String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError; //failure crash in server side
  static String NOT_FOUND =
      AppStrings.notFoundError; //failure crash in server side

  // local status code
  static String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static String CANCEL = AppStrings.CANCEL;
  static String RESIVE_TIMEOUT = AppStrings.timeoutError;
  static String SEND_TIMEOUT = AppStrings.timeoutError;
  static String CASHE_ERROR = AppStrings.cacheError;
  static String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static String DEFFAULT = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
