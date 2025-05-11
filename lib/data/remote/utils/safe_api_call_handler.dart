import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/utils/access_token_helper.dart';
import 'package:glint_frontend/utils/result_sealed.dart';


Future<Result<dynamic>> safeApiCallHandler({
  required MyDioClient httpClient,
  required HttpRequestEnum requestType,
  required AsyncEncryptedSharedPreferenceHelper sharedPrefHelper,
  required String endpoint,
  dynamic requestBody,
  Map<String, dynamic>? passedQueryParameters,
  FormData? uploadFilesFormData,
}) async {
  /**
   *  Checks if the Access Token is Valid or not.
   *  IF Not valid, we make another API call to update the Auth Token.
   *  By using the Refresh Token
   */
  final accessTokenHelper = await GetIt.instance.getAsync<AccessTokenHelper>();

  final isValidToken = await accessTokenHelper.isTokenValid();

  if (!isValidToken) {
    await accessTokenHelper.updateRefreshToken();
  }

  final accessToken =
      await sharedPrefHelper.getString(SharedPreferenceKeys.accessTokenKey);

  switch (requestType) {
    case HttpRequestEnum.GET:
      final result = httpClient.getRequest(
        endpoint: endpoint,
        queryParameters: passedQueryParameters,
        accessToken: accessToken,
      );
      return result;
    case HttpRequestEnum.POST:
      final result = httpClient.postRequest(
        endpoint: endpoint,
        body: requestBody,
        accessToken: accessToken,
      );
      return result;
    case HttpRequestEnum.PUT:
      final result = httpClient.putRequest(
        endpoint: endpoint,
        body: requestBody,
        accessToken: accessToken,
      );
      return result;
    case HttpRequestEnum.UPLOAD:
      final result = httpClient.uploadFiles(
          endpoint: endpoint, accessToken: accessToken, formData: uploadFilesFormData);
      return result;
  }
}
