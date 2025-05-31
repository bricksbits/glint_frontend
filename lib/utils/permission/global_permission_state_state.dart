part of 'global_permission_state_cubit.dart';

class GlobalPermissionState {
  final Map<Permission, PermissionStatus> permissions;

  GlobalPermissionState({required this.permissions});

  GlobalPermissionState copyWith({
    Map<Permission, PermissionStatus>? permissions,
  }) {
    return GlobalPermissionState(
      permissions: permissions ?? this.permissions,
    );
  }
}
