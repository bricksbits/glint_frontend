import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'profile_handling_state.dart';

part 'profile_handling_cubit.freezed.dart';

class ProfileHandlingCubit extends Cubit<ProfileHandlingState> {
  final profileRepo = getIt.get<ProfileRepo>();

  ProfileHandlingCubit() : super(const ProfileHandlingState.initial()) {
    getMembershipInfo();
    fetchCurrentProfile();
  }

  Future<void> getMembershipInfo() async {
    final membershipData = await profileRepo.getUserMembershipDetails();
    switch (membershipData) {
      case Success<ProfileMembershipEntity>():
        emitNewState(state.copyWith(membershipEntity: membershipData.data));
      case Failure<ProfileMembershipEntity>():
        var error = membershipData.error;
        emitNewState(
          state.copyWith(error: "No membership data found, $error"),
        );
    }
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
        getUserProfile();
        emitNewState(
          state.copyWith(
            isLoading: false,
            error: "No profile data found, please login again.",
          ),
        );
        break;
    }
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

  void emitNewState(ProfileHandlingState newState) {
    emit(newState);
  }
}
