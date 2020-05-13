import 'package:dio/dio.dart';

import 'package:saca/settings.dart';

class HttpService {
  Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: API_URL,
    ));
  }

  Dio get dio {
    return _dio;
  }

  void addToken(String token) {
    _dio.options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
  }
}
