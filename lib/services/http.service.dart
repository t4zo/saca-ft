import 'package:dio/dio.dart';
import 'package:saca/constants/http.constants.dart';

class HttpService {
  Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: HttpConstants.API_URL,
    ));
  }

  Dio get dio {
    return _dio;
  }

  void addToken(String token) {
    _dio.options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
  }
}
