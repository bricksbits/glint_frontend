import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_error_response_body.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

/// A Network Response Handler Class
/// Handles and return data based on the Status Code of the Response
/// Common for each API Call used along with `SafeApiCallHandler`,
///
Result<dynamic> networkResponseHandler(Response<dynamic>? response) {
  final responseStatusCode = response?.statusCode ?? 500;
  if (responseStatusCode >= 200 && responseStatusCode <= 299) {
    return Success(response?.data);
  }

  if (response == null) {
    return Failure(Exception(), message: "Empty Response");
  }

  return _parseError(response);
}

Result<T> _parseError<T>(Response response) {
  try {
    final errorData = UniversalErrorResponseBody.fromJson(response.data);
    return Failure(
      Exception(errorData),
      message: "${errorData.error?.message}",
    );
  } catch (exception) {
    return Failure(
      Exception(exception),
      message: "Request Failed, Unable to find root cause.",
    );
  }
}
