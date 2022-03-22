import 'package:flutter/widgets.dart';

import '../../../../commons/adapters/http_client/interfaces/http_client_adapter.dart';

class HomeController {
  final IHttpClientAdapter _http;
  HomeController({
    required IHttpClientAdapter http,
  }) : _http = http;

  teste() async {
    var result = await _http.post(
      '/posts',
      data: {
        'parametro': 'testeando',
      },
    );

    debugPrint('result: ${result.data?.toString() ?? ''}');
  }
}
