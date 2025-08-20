import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InterceptorApi extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["X-Parse-Application-Id"] = dotenv.get("API_ID");
    options.headers["X-Parse-REST-API-Key"] = dotenv.get("API_CLIENT_KEY");

    return super.onRequest(options, handler);
  }
}
