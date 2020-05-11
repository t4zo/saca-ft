import 'package:dio/dio.dart';

import '../settings.dart';

class HttpService {
  Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: API_URL,
      headers: {'Authorize': 'Bearer $token'},
    ));
  }

  Dio get dio {
    return _dio;
  }
}
