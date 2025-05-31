import 'package:bloc/bloc.dart';
import 'package:glint_frontend/services/permission_handler_service.dart';
import 'package:permission_handler/permission_handler.dart';

part 'global_permission_state_state.dart';

class GlobalPermissionStateCubit extends Cubit<GlobalPermissionState> {
  GlobalPermissionStateCubit() : super(GlobalPermissionState(permissions: {}));

  Future<void> updatePermission(
      Permission permission, {
        RationaleCallback? onRationale,
      }) async {
    final status = await PermissionHandlerService.checkAndRequest(
      permission: permission,
      onRationale: onRationale,
    );

    final updatedMap = Map.of(state.permissions);
    updatedMap[permission] = status;

    emit(state.copyWith(permissions: updatedMap));
  }

  bool isGranted(Permission permission) {
    return state.permissions[permission]?.isGranted ?? false;
  }
}

/// Example Usage of the Service nd the cubit here

// final permissionCubit = context.read<GlobalPermissionCubit>();
//
// final granted = permissionCubit.isGranted(Permission.location);
//
// if (!granted) {
//   permissionCubit.updatePermission(
//     Permission.location,
//     onRationale: (permission) async {
//       await MyDialogService.showInfo("Location access is required to continue.");
//     },
//   );
// }

// await PermissionHandlerService.checkAndRequest(
// permission: Permission.location,
// onRationale: (permission) async {
// // Show a dialog using a top-level service, overlay, or callback
// MyDialogService.showInfo("We need your location to show nearby people.");
// },
// );

