import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyDioClient {
  final Dio dioHttpClient;

  MyDioClient.test(this.dioHttpClient);

  MyDioClient(this.dioHttpClient) {
    dioHttpClient
      ..options.connectTimeout = const Duration(
        milliseconds: GlintApiConstants.apiTimeOut,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: GlintApiConstants.apiReceiveTimeOut,
      )
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
  }

  Future<Response<dynamic>?> getRequest(
    String url,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    String? accessToken,
  ) async {
    try {
      dioHttpClient.options.headers['Authorization'] = 'Bearer $accessToken';
      final response =
          await dioHttpClient.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (someException) {
      print(
          '[API Helper - GET] Connection Exception => ${someException.message}');
      return null;
    }
  }

  Future<Response<dynamic>?> postRequest(String url, dynamic body) async {
    try {
      dioHttpClient.options.headers['Content-Type'] =
          'application/x-www-form-urlencoded';
      final postResponse = await dioHttpClient.post(url, data: body);
      print("Status Code -> ${postResponse.statusCode}");
      return postResponse;
    } on DioException catch (exception) {
      print('[API Helper - POST] Connection Exception => ${exception.message}');
      return null;
    }
  }
}
