import 'package:encrypt_shared_preferences/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/utils/network_response.dart';

import '../utils/access_token_helper.dart';
import '../utils/network_response_handler.dart';

Future<Result<dynamic>> safeApiCallHandler({
  required MyDioClient httpClient,
  required HttpRequestEnum requestType,
  required EncryptedSharedPreferencesAsync sharedPreference,
  required String endpoint,
  dynamic requestBody,
  Map<String, dynamic>? passedQueryParameters,
}) async {
  /**
   *  Checks if the Access Token is Valid or not.
   *  IF Not valid, we make another API call to update the Auth Token.
   *  By using the Refresh Token
   */
  final accessTokenHelper = GetIt.instance.get<AccessTokenHelper>();

  final isValidToken = await accessTokenHelper.isTokenValid();

  if (!isValidToken) {
    await accessTokenHelper.updateRefreshToken();
  }

  /// Get Request needed access_token for each Request
  final accessToken = await sharedPreference.getString("") ?? "";

  switch (requestType) {
    case HttpRequestEnum.GET:
      final response = await httpClient.getRequest(
        endpoint: endpoint,
        queryParameters: passedQueryParameters,
        accessToken: accessToken,
      );
      return networkResponseHandler(response);
    case HttpRequestEnum.POST:
      final response = await httpClient.postRequest(
        endpoint: endpoint,
        body: requestBody,
        accessToken: accessToken,
      );
      return networkResponseHandler(response);
  }
}
