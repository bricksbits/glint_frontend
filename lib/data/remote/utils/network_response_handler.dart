import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

/// A Network Response Handler Class
/// Handles and return data based on the Status Code of the Response
/// Common for each API Call used along with `SafeApiCallHandler`,
///
Future<Result<dynamic>> networkResponseHandler(
    Response<dynamic>? response) async {
  try {
    final responseStatusCode = response?.statusCode ?? 404;
    if (responseStatusCode >= 200 && responseStatusCode <= 299) {
      // Returning the Raw data.
      return Success(response?.data);
    } else if (responseStatusCode >= 400 && responseStatusCode <= 499) {
      return Failure(
          Exception("Unauthorized Error, Status Code $responseStatusCode"));
    } else {
      return Failure(Exception("Something went wrong"));
    }
  } on TimeoutException catch (timeOutException) {
    return Failure(Exception("OnTimeout Exception $timeOutException"));
  } on RedirectException catch (redirectException) {
    return Failure(Exception("Redirection Exception $redirectException"));
  } on IOException catch (ioException) {
    return Failure(Exception("Exception caught $ioException"));
  } on Exception catch (someException) {
    return Failure(Exception("Exception caught $someException"));
  }
}
