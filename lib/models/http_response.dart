import 'package:dio/dio.dart';

class HttpResponse<T> {
  T response;
  DioError error;
  String errorMessage;

  HttpResponse({this.response, this.error, this.errorMessage});
}
