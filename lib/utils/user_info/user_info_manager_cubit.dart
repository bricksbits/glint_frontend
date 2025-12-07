import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/services/location_permission_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

part 'user_info_manager_state.dart';

part 'user_info_manager_cubit.freezed.dart';

@LazySingleton()
class UserInfoManagerCubit extends Cubit<UserInfoManagerState> {
  final userInfoRepo = getIt.get<UserInfoRepo>();
  final permissionService = getIt<LocationPermissionService>();
  final sharedPrefHelper = getIt<AsyncEncryptedSharedPreferenceHelper>();

  UserInfoManagerCubit() : super(const UserInfoManagerState.initial()) {
    pushFcmTokenToServer();
    getCurrentMembershipData();
    updateUserLastKnowLocation();
  }

  Future<void> updateTheFcmLocally(String fcmToken) async {
    await userInfoRepo.updateFcmTokenLocally(fcmToken);
  }

  Future<void> pushFcmTokenToServer() async {
    userInfoRepo.updateFcmTokenToServer();
  }

  Future<void> getCurrentMembershipData() async {
    await userInfoRepo.getCurrentUserPremiumInfo().then((result) {
      switch (result) {
        case Success<ProfileMembershipEntity>():
          emit(state.copyWith(membershipEntity: result.data));
          break;
        case Failure<ProfileMembershipEntity>():
          emit(state.copyWith(
              membershipEntity: null, error: "Error: ${result.error}"));
          break;
      }
    });
  }

  Future<void> superLikedUsed() async {
    final currentSuperLikedCount = state.membershipEntity?.superLikes ?? 0;
    if (currentSuperLikedCount <= 0) {
      emit(state.copyWith(error: "No more super likes left"));
    } else {
      final currentStateOfMembership = state.membershipEntity;
      if (currentStateOfMembership != null) {
        final updatedState = currentStateOfMembership.copyWith(
          superLikes: currentSuperLikedCount - 1,
        );
        emit(state.copyWith(membershipEntity: updatedState));
        final updateDbForSuperLikes =
            await userInfoRepo.updateCurrentPremiumInfo(updatedState);
      }
    }
  }

  Future<void> rewindUsed() async {
    final currentRewindCount = state.membershipEntity?.rewinds ?? 0;
    if (currentRewindCount <= 0) {
      emit(state.copyWith(error: "No more rewinds left"));
    } else {
      final currentStateOfMembership = state.membershipEntity;
      if (currentStateOfMembership != null) {
        final updatedState = currentStateOfMembership.copyWith(
          rewinds: currentRewindCount - 1,
        );
        emit(state.copyWith(membershipEntity: updatedState));
        final updateDbForRewinds =
            await userInfoRepo.updateCurrentPremiumInfo(updatedState);
      }
    }
  }

  Future<void> aiMessageUsed() async {
    final currentAiMessageCount = state.membershipEntity?.aiMessages ?? 0;
    if (currentAiMessageCount <= 0) {
      emit(state.copyWith(error: "No more rewinds left"));
    } else {
      final currentStateOfMembership = state.membershipEntity;
      if (currentStateOfMembership != null) {
        final updatedState = currentStateOfMembership.copyWith(
          aiMessages: currentAiMessageCount - 1,
        );
        emit(state.copyWith(membershipEntity: updatedState));
        final updateDbForAiMessages =
            await userInfoRepo.updateCurrentPremiumInfo(updatedState);
      }
    }
  }

  Future<void> directDmUsed() async {
    final currentDmCount = state.membershipEntity?.superDm ?? 0;
    if (currentDmCount <= 0) {
      emit(state.copyWith(error: "No more rewinds left"));
    } else {
      final currentStateOfMembership = state.membershipEntity;
      if (currentStateOfMembership != null) {
        final updatedState = currentStateOfMembership.copyWith(
          superDm: currentDmCount - 1,
        );
        emit(state.copyWith(membershipEntity: updatedState));
        final updateDbForSuperDm =
            await userInfoRepo.updateCurrentPremiumInfo(updatedState);
      }
    }
  }

  Future<void> updateUserLocation() async {
    final isPermissionStillAvailable =
        await permissionService.requestPermission();
    if (isPermissionStillAvailable) {
      final getCurrentLocation = await permissionService.getCurrentLocation();
      await sharedPrefHelper.saveDouble(SharedPreferenceKeys.userLatitudeKey,
          getCurrentLocation?.latitude ?? 24.7);
      await sharedPrefHelper.saveDouble(SharedPreferenceKeys.userLongitudeKey,
          getCurrentLocation?.longitude ?? 77.41);
    }
  }

  Future<void> updateUserLastKnowLocation() async {
    userInfoRepo.updateUserLocation();
  }

  void emitNewStatee(UserInfoManagerState newState) {
    emit(newState);
  }
}
