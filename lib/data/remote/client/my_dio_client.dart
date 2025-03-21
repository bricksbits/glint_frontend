import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
import 'package:glint_frontend/data/remote/utils/network_response_handler.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyDioClient {
  final Dio dioHttpClient;

  MyDioClient.test(this.dioHttpClient);

  MyDioClient(this.dioHttpClient) {
    dioHttpClient.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }

  Future<Result<dynamic>> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? accessToken,
    // CancelToken? cancelToken,
  }) async {
    try {
      dioHttpClient.options.headers['Auth'] = accessToken;
      final response = await dioHttpClient.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return networkResponseHandler(response);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Future<Result<dynamic>> postRequest({
    required String endpoint,
    required dynamic body,
    required String? accessToken,
  }) async {
    if (accessToken != null) {
      dioHttpClient.options.headers['Auth'] = accessToken;
    }
    try {
      final postResponse = await dioHttpClient.post(endpoint, data: body);
      return networkResponseHandler(postResponse);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Future<Result<dynamic>> putRequest({
    required String endpoint,
    required dynamic body,
    required String? accessToken,
  }) async {
    if (accessToken != null) {
      dioHttpClient.options.headers['Auth'] = accessToken;
    }
    try {
      final postResponse = await dioHttpClient.put(endpoint, data: body);
      return networkResponseHandler(postResponse);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }
}
