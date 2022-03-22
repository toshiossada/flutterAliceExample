import 'package:alice_lightweight/alice.dart';
import 'package:dio/dio.dart' as dio;
import 'package:example/app/modules/home/home_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'commons/adapters/http_client/dio_adapter.dart';
import 'commons/adapters/http_client/interceptors/dio_interceptor.dart';
import 'commons/adapters/http_client/interfaces/http_client_adapter.dart';
import 'commons/services/local_notification_service.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => dio.Dio(i())),
        Bind.factory<IHttpClientAdapter>((i) => DioAdapter(
              dio: i(),
              insterceptors: [
                i<CustomInterceptors>(),
                ...(kDebugMode) ? [i<Alice>().getDioInterceptor()] : []
              ],
            )),
        Bind.factory<CustomInterceptors>((i) => CustomInterceptors(
              localNotificationService: i(),
            )),
        // Bind.factory((i) => dio.Dio(
        //       dio.BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
        //     )..interceptors.addAll(
        //         [
        //           i<CustomInterceptors>(),
        //           i<Alice>().getDioInterceptor(),
        //         ],
        //       )),

        Bind.singleton((i) => Alice()),
        Bind.singleton((i) => LocalNotificationService(alice: i())),
        Bind.factory<dio.BaseOptions>((i) =>
            dio.BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
      ];
}
