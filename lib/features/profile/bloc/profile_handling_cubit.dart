import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'profile_handling_state.dart';

part 'profile_handling_cubit.freezed.dart';

class ProfileHandlingCubit extends Cubit<ProfileHandlingState> {
  final profileRepo = getIt.get<ProfileRepo>();
  late final StreamSubscription<ProfileMembershipEntity?>
      profileMembershipPerks;

  ProfileHandlingCubit() : super(const ProfileHandlingState.initial()) {
    getUserProfile();
    getMembershipInfo();
  }

  Future<void> getUserProfile() async {
    emitNewState(state.copyWith(isLoading: true));
    final itsMeResponse = await profileRepo.getAndCacheUserProfile();
    switch (itsMeResponse) {
      case Success<void>():
        fetchCurrentProfile();
        break;
      case Failure<void>():
        emitNewState(state.copyWith(isLoading: false));
        emitNewState(
          state.copyWith(
            error: "Server Went down, can't fetch profile currently",
            isLoading: false,
          ),
        );
        break;
    }
  }

  void getMembershipInfo() {
    profileMembershipPerks =
        profileRepo.getUserMembershipDetails().distinct().listen((membership) {
      if (membership != null) {
        emitNewState(state.copyWith(membershipEntity: membership));
      } else {
        emitNewState(
          state.copyWith(error: "No, membership perks found."),
        );
      }
    }, onError: (error) {
      emitNewState(state.copyWith(error: "DB issue, "));
    });
  }

  Future<void> fetchCurrentProfile() async {
    emitNewState(state.copyWith(isLoading: true));
    final currentProfile = await profileRepo.fetchUserProfile();
    switch (currentProfile) {
      case Success<PeopleCardModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
            previewProfileModel: currentProfile.data,
          ),
        );
        break;
      case Failure<PeopleCardModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
            error: "No profile data found, please login again.",
          ),
        );
        break;
    }
  }



  void emitNewState(ProfileHandlingState newState) {
    emit(newState);
  }

  @override
  Future<void> close() {
    profileMembershipPerks.cancel();
    return super.close();
  }
}
