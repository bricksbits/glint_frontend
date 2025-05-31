import 'package:permission_handler/permission_handler.dart';

typedef RationaleCallback = Future<void> Function(Permission permission);

class PermissionHandlerService {
  static Future<PermissionStatus> checkAndRequest({
    required Permission permission,
    RationaleCallback? onRationale,
  }) async {
    final status = await permission.status;

    // Already granted
    if (status.isGranted) return status;

    // Should show rationale (Android only)
    if (status.isDenied && await permission.shouldShowRequestRationale) {
      if (onRationale != null) {
        await onRationale(permission);
      }
    }

    // Request permission
    final newStatus = await permission.request();

    // Denied permanently → open settings
    if (newStatus.isPermanentlyDenied) {
      await openAppSettings();
    }

    return newStatus;
  }
}
