import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
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

  Future<Response<dynamic>?> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? accessToken,
    // CancelToken? cancelToken,
  }) async {
    try {
      dioHttpClient.options.headers['Auth'] = accessToken;
      final response = await dioHttpClient.get(GlintApiConstants.glintBaseUrl,
          queryParameters: queryParameters);
      return response;
    } on DioException catch (someException) {
      print(
          '[API Helper - GET] Connection Exception => ${someException.message}');
      return null;
    }
  }

  //Todo: GO Make it Generic
  // Handle Errors as well
  Future<Response<dynamic>?> postRequest({
    required String endpoint,
    required dynamic body,
    required String accessToken,
  }) async {
    dioHttpClient.options.headers['Auth'] = accessToken;
    try {
      dioHttpClient.options.headers['Content-Type'] =
          'application/x-www-form-urlencoded';
      final postResponse =
          await dioHttpClient.post(endpoint, data: body);
      print("Status Code -> ${postResponse.statusCode}");
      return postResponse;
    } on DioException catch (exception) {
      print('[API Helper - POST] Connection Exception => ${exception.message}');
      return null;
    }
  }
}
