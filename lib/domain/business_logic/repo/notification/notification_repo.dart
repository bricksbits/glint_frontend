import 'package:glint_frontend/utils/network_response.dart';

abstract class NotificationRepo {
  Future<Result<void>> getLatestNotifications();

  Future<Result<void>> getAllNotifications();

  Future<Result<void>> deleteOldNotifications();
}
