import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class RequestResult {
  dynamic json;
  int? statusCode;

  RequestResult(this.json, this.statusCode);
}

abstract class ApiBase {
  late String endpoint;

  final Dio _dio = Dio();
  ApiBase() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<RequestResult> request({
    required String method,
    required String path,
    required Map<String, String> headers,
    dynamic body,
    Map<String, String>? queryParameters,
    bool customPath = false,
    String contentType = 'application/json',
  }) async {
    path = customPath ? endpoint : path;
    Response? resp;
    dynamic decodedJson;

    _dio.options.headers['Accept'] = 'application/json';

    print(path);
    try {
      switch (method) {
        case 'post':
          resp = await _dio.post(path,
              data: body,
              options: Options(
                contentType: contentType,
                headers: headers,
              ),
              queryParameters: queryParameters);
          break;
        case 'get':
          resp = await _dio.get(path,
              queryParameters: queryParameters,
              options: Options(
                headers: headers,
              ));
          break;
        case 'delete':
          resp = await _dio.delete(path,
              queryParameters: queryParameters,
              options: Options(
                headers: headers,
              ));
          break;
        case "put":
          resp = await _dio.put(path,
              data: body,
              queryParameters: queryParameters,
              options: Options(
                contentType: contentType,
                headers: headers,
              ));
          break;
        case "patch":
          resp = await _dio.patch(path,
              data: body,
              queryParameters: queryParameters,
              options: Options(
                contentType: contentType,
                headers: headers,
              ));
          break;
      }
      decodedJson = resp!.data;
    } catch (e, st) {
      log("""HTTP Request error: 
            statusCode: ${resp?.statusCode}
            body: ${resp?.data}
            exception: $e
            stackTrace: $st
            """);

      decodedJson = Map.from(<String, dynamic>{});
      rethrow;
    }
    return RequestResult(decodedJson, resp.statusCode);
  }

  void initAdapter() {
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
        return client;
      },
    );
  }

  Future<RequestResult> post(
    String path, {
    Map<String, String> headers = const {},
    dynamic body = '',
    bool customPath = false,
    String contentType = "application/json",
    Map<String, String>? queryParameters,
  }) async {
    headers = Map<String, String>.from(headers);

    return request(
      method: 'post',
      path: path,
      headers: headers,
      body: body,
      contentType: contentType,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> delete(
    String path, {
    Map<String, String> headers = const {},
    bool customPath = false,
    Map<String, String>? queryParameters,
  }) async {
    headers = Map<String, String>.from(headers);

    return request(
      method: 'delete',
      path: path,
      headers: headers,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> put(String path,
      {Map<String, String> headers = const {},
      dynamic body = '',
      bool customPath = false,
      Map<String, String>? queryParameters,
      String contentType = "application/json"}) async {
    headers = Map<String, String>.from(headers);
    return request(
      method: 'put',
      path: path,
      headers: headers,
      body: body,
      customPath: customPath,
      contentType: contentType,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> patch(String path,
      {Map<String, String> headers = const {},
      dynamic body = '',
      bool customPath = false,
      Map<String, String>? queryParameters,
      String contentType = "application/json"}) async {
    headers = Map<String, String>.from(headers);
    return request(
      method: 'patch',
      path: path,
      headers: headers,
      body: body,
      customPath: customPath,
      contentType: contentType,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> get(
    String path, {
    Map<String, String> headers = const {},
    bool customPath = false,
    Map<String, String>? queryParameters,
  }) async {
    return request(
      method: 'get',
      path: path,
      headers: headers,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
