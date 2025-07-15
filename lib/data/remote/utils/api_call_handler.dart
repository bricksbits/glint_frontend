import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

Future<Result<dynamic>> apiCallHandler({
  required MyDioClient httpClient,
  required HttpRequestEnum requestType,
  required String endpoint,
  dynamic requestBody,
  Map<String, dynamic>? passedQueryParameters,
  FormData? uploadFilesFormData,
}) async {
  switch (requestType) {
    case HttpRequestEnum.GET:
      final result = httpClient.getRequest(
        endpoint: endpoint,
        queryParameters: passedQueryParameters,
      );
      return result;
    case HttpRequestEnum.POST:
      final result = httpClient.postRequest(
        endpoint: endpoint,
        body: requestBody,
      );
      return result;
    case HttpRequestEnum.PUT:
      final result = httpClient.putRequest(
        endpoint: endpoint,
        body: requestBody,
      );
      return result;
    case HttpRequestEnum.UPLOAD:
      final result = httpClient.uploadFiles(
        endpoint: endpoint,
        formData: uploadFilesFormData,
      );
      return result;
    case HttpRequestEnum.DELETE:
      final result = httpClient.deleteFiles(
        endpoint: endpoint,
        formData: uploadFilesFormData,
      );
      return result;
  }
}
