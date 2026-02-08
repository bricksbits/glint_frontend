import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/services/location_permission_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as streamChat;

part 'user_info_manager_state.dart';

part 'user_info_manager_cubit.freezed.dart';

@LazySingleton()
class UserInfoManagerCubit extends Cubit<UserInfoManagerState> {
  final userInfoRepo = getIt.get<UserInfoRepo>();
  final permissionService = getIt.get<LocationPermissionService>();
  final sharedPrefHelper = getIt.get<AsyncEncryptedSharedPreferenceHelper>();
  final chatWithRepo = getIt.get<ChatWithRepo>();
  StreamSubscription<ProfileMembershipEntity?>? profileMembershipPerks;

  UserInfoManagerCubit() : super(const UserInfoManagerState.initial()) {
    pushFcmTokenToServer();
  }

  Future<void> updateTheFcmLocally(String fcmToken) async {
    await userInfoRepo.updateFcmTokenLocally(fcmToken);
  }

  Future<void> pushFcmTokenToServer() async {
    userInfoRepo.updateFcmTokenToServer();
  }

  void getCurrentMembershipData() {
    profileMembershipPerks =
        userInfoRepo.getLocalUserPremiumInfo().distinct().listen(
      (membership) {
        if (membership != null) {
          emitNewState(
            state.copyWith(
              membershipEntity: membership,
              isPremiumUser: membership.isPremium,
            ),
          );
        } else {
          debugLogger("[UserInfoCubit]", "No Membership data found");
        }
      },
      onError: (error) {
        emitNewState(state.copyWith(error: "DB issue, "));
      },
    );
  }

  bool superLikeClicked() {
    if (state.isPremiumUser) {
      final currentSuperLikesCount = state.membershipEntity?.superLikes ?? 0;
      if (currentSuperLikesCount <= 0) {
        emit(state.copyWith(error: "No more likes left"));
        return false;
      }
      return true;
    } else {
      emitNewState(state.copyWith(error: "No Super Likes available"));
      return false;
    }
  }

  bool rewindClicked() {
    if (state.isPremiumUser) {
      return true;
    } else {
      emitNewState(state.copyWith(error: "No Rewinds available"));
      return false;
    }
  }

  bool superDmClicked() {
    if (state.isPremiumUser) {
      final currentDmCount = state.membershipEntity?.superDm ?? 0;
      if (currentDmCount <= 0) {
        emit(state.copyWith(error: "No more DM's left"));
        return false;
      }
      return true;
    } else {
      emitNewState(state.copyWith(error: "No Messages available."));
      return false;
    }
  }

  Future<String?> getSuperDmChannelId(String onUserId) async {
    emitNewState(state.copyWith(isLoading: true));
    final channelId =
        await userInfoRepo.fetchDirectDmChannelIdWithUserId(onUserId);
    return channelId;
  }

  Future<void> sendSuperDm(
    String onUserId,
    String message,
    streamChat.StreamChatClient client,
  ) async {
    final channelId = await getSuperDmChannelId(onUserId);
    if (channelId != null) {
      emitNewState(state.copyWith(isLoading: false));
      final newChannel = client.channel('messaging', id: channelId);
      chatWithRepo.sendTextMessage(client, newChannel, message);
      updateSuperDmCountAfterSuccessfulDm();
    }
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
        await userInfoRepo.setLocalUserPremiumInfo(updatedState);
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
        await userInfoRepo.setLocalUserPremiumInfo(updatedState);
        await userInfoRepo.updateRewindAndAiCountToServer();
      }
    }
  }

  Future<void> aiMessageUsed() async {
    final currentAiMessageCount = state.membershipEntity?.aiMessages ?? 0;
    if (currentAiMessageCount <= 0) {
      emit(state.copyWith(error: "No more AI messages left"));
    } else {
      final currentStateOfMembership = state.membershipEntity;
      if (currentStateOfMembership != null) {
        final updatedState = currentStateOfMembership.copyWith(
          aiMessages: currentAiMessageCount - 1,
        );
        emit(state.copyWith(membershipEntity: updatedState));
        await userInfoRepo.setLocalUserPremiumInfo(updatedState);
      }
    }
  }

  Future<void> updateSuperDmCountAfterSuccessfulDm() async {
    final currentDmCount = state.membershipEntity?.superDm ?? 0;
    final currentStateOfMembership = state.membershipEntity;
    if (currentStateOfMembership != null) {
      final updatedState = currentStateOfMembership.copyWith(
        superDm: currentDmCount - 1,
      );
      emit(state.copyWith(membershipEntity: updatedState));
      await userInfoRepo.setLocalUserPremiumInfo(updatedState);
    }
  }

  Future<void> updateUserLocationLocally() async {
    final isPermissionStillAvailable =
        await permissionService.requestPermission();
    if (isPermissionStillAvailable) {
      final getCurrentLocation = await permissionService.getCurrentLocation();
      await sharedPrefHelper.saveDouble(SharedPreferenceKeys.userLatitudeKey,
          getCurrentLocation?.latitude ?? 24.7);
      await sharedPrefHelper.saveDouble(SharedPreferenceKeys.userLongitudeKey,
          getCurrentLocation?.longitude ?? 77.41);
      updateUserLastKnowLocation();
    }
  }

  Future<void> _clearTheSearchSettings() async {
    await sharedPrefHelper.saveString(
        SharedPreferenceKeys.userSearchMaxDistanceKey, "");
    await sharedPrefHelper.saveString(
        SharedPreferenceKeys.userSearchMinAgeKey, "");
    await sharedPrefHelper.saveString(
        SharedPreferenceKeys.userSearchMaxAgeKey, "");
  }

  Future<void> updateUserLastKnowLocation() async {
    userInfoRepo.updateUserLocation();
  }

  Future<void> fetchPremiumStatus() async {
    final isPremiumUser = await userInfoRepo.isPremiumUser();
    emitNewState(state.copyWith(isPremiumUser: isPremiumUser));
  }

  void setupFirebaseNotification() async {
    final firebaseInstance = FirebaseMessaging.instance;
    final notificationSettings = await firebaseInstance.requestPermission(
      provisional: true,
    );
    if (notificationSettings.authorizationStatus ==
            AuthorizationStatus.authorized ||
        notificationSettings.authorizationStatus ==
            AuthorizationStatus.provisional) {
      final fcmToken = await firebaseInstance.getToken();
      if (fcmToken != null) {
        debugLogger(
            "FIREBASE TOKEN FETCH", "Token fetched at startup: $fcmToken");
        updateTheFcmLocally(fcmToken);
      } else {
        debugLogger("FIREBASE TOKEN FETCH",
            "Failed to fetch token at startup, it was null.");
      }

      firebaseInstance.onTokenRefresh.listen((newToken) {
        debugLogger("FIREBASE TOKEN REFRESH", "New Token generated: $newToken");
        updateTheFcmLocally(newToken);
      }).onError((error) {
        debugLogger(
            "FIREBASE TOKEN REFRESH", "Failed to generate the token, ${error}");
        //Todo: Log the Error to the Analytic here.
      });
    } else {
      debugLogger("FIREBASE PERMISSIONS",
          "User did not grant notification permissions.");
    }
  }

  void emitNewState(UserInfoManagerState newState) {
    emit(newState);
  }

  void clearError() {
    emitNewState(state.copyWith(error: null));
  }

  @override
  Future<void> close() {
    profileMembershipPerks?.cancel();
    _clearTheSearchSettings();
    return super.close();
  }
}
