import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saca/constants/http.constants.dart';

class HttpService {
  Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: HttpConstants.API_URL,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ));
      // ..interceptors.add(
        // InterceptorsWrapper(onRequest: (RequestOptions requestOptions) async {
        //   dio.interceptors.requestLock.lock();

        //   final preferences = await SharedPreferences.getInstance();
        //   if (!preferences.containsKey('@session')) {
        //     dio.interceptors.requestLock.unlock();
        //     return requestOptions;
        //   }

        //   final session = json.decode(preferences.getString('@session'))
        //       as Map<String, Object>;
        //   User user = User.fromJson(session['user']);

        //   if (user.token != null) {
        //     dio.options.headers[HttpHeaders.authorizationHeader] =
        //         'Bearer ' + user.token;
        //   }

        //   dio.interceptors.requestLock.unlock();
        //   return requestOptions;
        // }),
      // );
  }

  Dio get dio => _dio;

  void addToken(String token) {
    _dio.options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
  }
}
