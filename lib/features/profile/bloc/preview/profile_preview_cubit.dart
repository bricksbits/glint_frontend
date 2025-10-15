import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'profile_preview_state.dart';

part 'profile_preview_cubit.freezed.dart';

class ProfilePreviewCubit extends Cubit<ProfilePreviewState> {
  final profileRepo = getIt.get<ProfileRepo>();

  ProfilePreviewCubit() : super(const ProfilePreviewState.initial()) {
    fetchCurrentProfile();
  }

  Future<void> fetchCurrentProfile() async {
    emitNewState(state.copyWith(isLoading: true));
    final currentProfile = await profileRepo.fetchUserProfile();
    switch (currentProfile) {
      case Success<PeopleCardModel>():
        debugLogger("ProfilePreview", currentProfile.data.pictureUrlList.length.toString());
        emitNewState(
          state.copyWith(
            previewProfileModel: currentProfile.data,
            isLoading: false,
          ),
        );
      case Failure<PeopleCardModel>():
        emitNewState(
          state.copyWith(
            error: "No profile data found, please login again.",
            isLoading: false,
          ),
        );
    }
  }

  void emitNewState(ProfilePreviewState newState) {
    emit(newState);
  }
}
