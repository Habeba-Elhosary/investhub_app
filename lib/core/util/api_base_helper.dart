// ignore_for_file: always_specify_types, strict_top_level_inference
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/flavors/flavors_config.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum CodeStatus { defaultCode, activation }

Map<String, String> headers = <String, String>{
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

String baseUrl = FlavorConfig.instance.variables['baseUrl'];
List<Duration> generateExponentialDelays() {
  const int maxRetries = 50;
  const int initialDelaySeconds = 1;
  const int maxDelaySeconds = 300;
  final List<Duration> delays = [];
  for (int i = 0; i < maxRetries; i++) {
    final int delaySeconds = initialDelaySeconds * (1 << i); // 2^i
    delays.add(
      Duration(
        seconds: delaySeconds > maxDelaySeconds
            ? maxDelaySeconds
            : delaySeconds,
      ),
    );
  }
  return delays;
}

class ApiBaseHelper {
  final Dio dio;

  static const String versionNumber = 'v1';

  ApiBaseHelper({required this.dio}) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final lang = EasyLocalization.of(
            appNavigator.navigatorKey.currentContext!,
          )!.locale.languageCode;
          options.headers['Accept-Language'] = lang;
          return handler.next(options);
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        request: true,
      ),
      RetryInterceptor(
        dio: dio,
        logPrint: (message) => debugPrint(message),
        retries: 3,
        retryDelays: generateExponentialDelays(),
        retryEvaluator: (DioException error, int attempt) {
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.unknown ||
              error.error is HttpException) {
            return true;
          }
          return false;
        },
      ),
    ]);
  }

  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        dio.options.headers = headers;
      }
      final Response response = await dio.get(
        url,
        data: body,
        queryParameters: queryParameters,
      );
      log(body.toString());
      final responseJson = _returnResponse(response);
      return responseJson;
    } on Exception catch (error) {
      if (error is DioException && error.response != null) {
        _returnResponse(error.response);
      }
      throw ServerException(message: handleException(error));
    }
  }

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        dio.options.headers = headers;
      } else {
        headers.remove('Authorization');
        dio.options.headers = headers;
      }
      FormData formData = FormData.fromMap(body);
      final Response response = await dio.post(
        url,
        data: formData,
        queryParameters: queryParameters,
      );
      final responseJson = _returnResponse(response);
      return responseJson;
    } on Exception catch (error) {
      if (error is DioException && error.response != null) {
        _returnResponse(error.response);
      }
      throw ServerException(message: handleException(error));
    }
  }

  Future<dynamic> delete({required String url, String? token}) async {
    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        dio.options.headers = headers;
      }
      final Response response = await dio.delete(url);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on Exception catch (error) {
      if (error is DioException && error.response != null) {
        _returnResponse(error.response);
      }
      throw ServerException(message: handleException(error));
    }
  }

  dynamic _returnResponse(Response? response) {
    if (response == null) {
      throw ServerException(message: LocaleKeys.errorsMessage_server_500.tr());
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ServerException(
          message: response.data['message'],
          errorMap: response.data['errors'],
        );
      case 422:
        throw ServerException(
          message: response.data['message'],
          errorMap: response.data['errors'],
        );
      case 409:
        throw OldVersionException();
      case 451:
        throw TraderAlreadyExistException.fromJson(response.data['data']);
      case 403:
      case 401:
        throw ServerException(message: response.data['message']);
      case 500:
        throw ServerException(
          message: LocaleKeys.errorsMessage_server_500.tr(),
        );
      default:
        throw ServerException(
          message: LocaleKeys.errorsMessage_no_internet.tr(),
        );
    }
  }
}

String handleException(Exception error) {
  if (error.toString().contains('SocketException')) {
    return tr(LocaleKeys.errorsMessage_check_internet_connection);
  } else if (error.runtimeType == DioException) {
    DioException dioError = error as DioException;
    switch (dioError.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        return LocaleKeys
            .errorsMessage_connection_timed_out_please_check_your_internet_speed
            .tr();
      case DioExceptionType.badResponse:
        return dioError.response?.data['message'] ??
            LocaleKeys.errorsMessage_there_was_an_error_responding.tr();
      case DioExceptionType.cancel:
        return LocaleKeys.errorsMessage_the_order_has_been_cancelled.tr();
      case DioExceptionType.unknown:
      default:
        return LocaleKeys.errorsMessage_something_went_wrong.tr();
    }
  } else {
    return LocaleKeys.errorsMessage_something_went_wrong.tr();
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, '');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, 'Unauthorized: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
