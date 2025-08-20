import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ViaCepProvider {
  final _dio = Dio();

  Dio get dio => _dio;

  ViaCepProvider() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("VIACEP_URL");
  }
}
