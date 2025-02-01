import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/utils/api_response.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';

import '../utils/access_token_helper.dart';
import '../utils/network_response_handler.dart';

Future<ApiResponse<dynamic>> safeApiCallHandler(
  MyDioClient httpClient,
  HttpRequestEnum requestType,
  String url,
  EncryptedSharedPreferencesAsync sharedPreference,
  dynamic requestBody,
) async {
  // Checks if the Access Token is Valid or not.
  // IF Not valid, we make another API call to update the Refresh Token.
  final isValidToken = await AccessTokenHelper().isTokenValid();

  if (!isValidToken) {
    await AccessTokenHelper().updateRefreshToken(httpClient);
  }

  /// Get Request needed access_token for each Request
  switch (requestType) {
    case HttpRequestEnum.GET:
      final accessToken = sharedPreference.getString("");
      final response =
          await httpClient.getRequest(url, null, null, "accessToken");
      return networkResponseHandler(response);
    case HttpRequestEnum.POST:
      final response = await httpClient.postRequest(url, requestBody);
      return networkResponseHandler(response);
  }
}
