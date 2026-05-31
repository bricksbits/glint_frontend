import 'package:glint_frontend/notifications/models/notification_history_response.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class NotificationRepo {
  Future<Result<NotificationHistoryResponse>> getNotificationHistory(
      int offset);

  Future<Result<void>> markAllNotificationsRead();

  Future<Result<void>> markNotificationReadById(int id);

  Future<Result<void>> updateFcmToken(String fcmToken);
}
