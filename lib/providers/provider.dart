import 'package:consult_cep_flutter_app/providers/interceptor_api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Provider {
  final _dio = Dio();

  Dio get dio => _dio;

  Provider() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("API_URL");
    _dio.interceptors.add(InterceptorApi());
  }
}
