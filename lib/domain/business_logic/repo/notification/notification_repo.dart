import 'package:glint_frontend/utils/network_response.dart';

abstract class NotificationRepo {
  Future<NetworkResponse<void>> getLatestNotifications();

  Future<NetworkResponse<void>> getAllNotifications();

  Future<NetworkResponse<void>> deleteOldNotifications();
}
