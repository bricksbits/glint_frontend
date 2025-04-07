import 'package:glint_frontend/utils/result_sealed.dart';

abstract class NotificationRepo {
  Future<Result<void>> getLatestNotifications();

  Future<Result<void>> getAllNotifications();

  Future<Result<void>> deleteOldNotifications();
}
