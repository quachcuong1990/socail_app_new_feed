
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail/providers/log_provider.dart';
import 'package:socail/resources/token_manager.dart';
import 'package:socail/utils/config_env.dart';

import '../src/day04/error_response.dart';
import '../src/day05/models/public.dart';

dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}
class ApiProvider{
  late Dio _dio;
  String? get _accessToken{
    return userToken;
  }
  static final ApiProvider _instance = ApiProvider._internal();
  LogProvider get logger => const LogProvider('⚡️ ApiProviderVip');
  factory ApiProvider(){
    return _instance;
  }
  ApiProvider._internal(){
    final baseOption = BaseOptions(baseUrl: ConfigEnv.getDomainAPI());
    _dio = Dio(baseOption);
    setupInterceptors();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        _parseAndDecode;

  }

  void setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options, RequestInterceptorHandler handler)async{
      logger.log('[${options.method}] - ${options.uri}');
      if(_accessToken!.isEmpty){
        _dio.lock();
        return SharedPreferences.getInstance().then((sharedPreferences){
          TokenManager().load(sharedPreferences);
          logger.log('calling with access token: $_accessToken');
          options.headers['Authorization'] = 'Bearer $_accessToken';
          _dio.unlock();
          return handler.next(options);
        });
      }
      options.headers['Authorization'] = 'Bearer $_accessToken';
      return handler.next(options); //continue
    }, onResponse: (response,handler){
      return handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) async {
      logger.log(e.response.toString());
      return handler.next(e);
    }));
  }
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    final res = await _dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);

    if (res is! ErrorResponse) return res;
    throw res;
  }

  Future<Response> post(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    final res = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    if (res is! ErrorResponse) {
      return res;
    }
    throw res;
  }


}