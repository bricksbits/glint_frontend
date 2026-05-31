import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/notification/notification_repo.dart';
import 'package:glint_frontend/notifications/models/notification_history_response.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepo)
class NotificationRepoImpl extends NotificationRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  NotificationRepoImpl(this.httpClient, this.sharedPreferenceHelper);

  @override
  Future<Result<NotificationHistoryResponse>> getNotificationHistory(
      int offset) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: '/user/notifications',
      requestBody: null,
      passedQueryParameters: {'offset': offset},
    );
    switch (response) {
      case Success():
        try {
          final notificationResponse = UniversalSuccessResponseBody.fromJson(
            response.data,
            (filteredJson) =>
                NotificationHistoryResponse.fromJson(filteredJson),
          );
          if (notificationResponse.success == true &&
              notificationResponse.data != null) {
            return Success(notificationResponse.data!);
          } else {
            return Failure(Exception('Failed to parse notifications:'));
          }
        } catch (e) {
          return Failure(Exception('Failed to parse notifications: $e'));
        }
      case Failure():
        return Failure(Exception(response.error), message: response.message);
    }
  }

  @override
  Future<Result<void>> markAllNotificationsRead() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: '/user/notifications/read',
      requestBody: null,
      passedQueryParameters: null,
    );
    switch (response) {
      case Success():
        return const Success(null);
      case Failure():
        return Failure(Exception(response.error), message: response.message);
    }
  }

  @override
  Future<Result<void>> markNotificationReadById(int id) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: '/user/notifications/$id/read',
      requestBody: null,
      passedQueryParameters: null,
    );
    switch (response) {
      case Success():
        return const Success(null);
      case Failure():
        return Failure(Exception(response.error), message: response.message);
    }
  }

  @override
  Future<Result<void>> updateFcmToken(String fcmToken) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: '/user/notification',
      requestBody: {'fcm_token': fcmToken},
      passedQueryParameters: null,
    );
    switch (response) {
      case Success():
        return const Success(null);
      case Failure():
        return Failure(Exception(response.error), message: response.message);
    }
  }
}
