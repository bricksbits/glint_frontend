import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/auth_token_interceptor.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
import 'package:glint_frontend/data/remote/utils/network_response_handler.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyDioClient {
  final Dio dioHttpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  MyDioClient.test(this.dioHttpClient, this.sharedPreferenceHelper);

  MyDioClient(this.dioHttpClient, this.sharedPreferenceHelper) {
    dioHttpClient.interceptors.addAll([
      AuthInterceptor(sharedPreferenceHelper, dioHttpClient),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      )
    ]);
  }

  Future<Result<dynamic>> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
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
  }) async {
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
  }) async {
    try {
      final postResponse = await dioHttpClient.put(endpoint, data: body);
      return networkResponseHandler(postResponse);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Future<Result<dynamic>> uploadFiles({
    required String endpoint,
    required FormData? formData,
  }) async {
    if (formData == null) {
      return Failure(Exception("Can't Upload, if there are no files."));
    }

    if (formData.files.isEmpty) {
      return Failure(Exception("Can't Upload, if there are no files."));
    }

    try {
      final uploadFileResponse =
          await dioHttpClient.post(endpoint, data: formData);
      return networkResponseHandler(uploadFileResponse);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Future<Result<dynamic>> deleteFiles({
    required String endpoint,
    required FormData? formData,
  }) async {
    if (formData == null) {
      return Failure(
        Exception("Can't delete, if there are no files."),
      );
    }

    if (formData.files.isEmpty) {
      return Failure(
        Exception("Can't delete, if there are no files."),
      );
    }

    try {
      final deletedFilesResponse =
          await dioHttpClient.delete(endpoint, data: formData);
      return networkResponseHandler(deletedFilesResponse);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }
}
