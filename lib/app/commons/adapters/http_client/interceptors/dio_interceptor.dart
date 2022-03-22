import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../erros.dart';
import '../../../services/local_notification_service.dart';

class CustomInterceptors extends InterceptorsWrapper {
  final LocalNotificationService _localNotificationService;

  CustomInterceptors({
    required LocalNotificationService localNotificationService,
  }) : _localNotificationService = localNotificationService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //Imprimindo informações do request para debug
    if (kDebugMode) {
      _localNotificationService.show(
        title: options.baseUrl,
        body: '${options.method}: ${options.path}',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint("response: ${json.encode(response.data)}");
    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    HttpClientError failure;
    if (err.response?.statusCode == 401) {
      failure = HttpClientError(
          message: 'Falha ao realizar login.',
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response);
    } else {
      failure = HttpClientError(
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response,
          message: 'Ocorreu um erro na requisição com o servidor');
    }

    handler.next(failure);
  }
}
