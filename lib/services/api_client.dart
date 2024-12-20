import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl = "http://localhost:8090/api/v1/";

  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl
    ),
  );
}
