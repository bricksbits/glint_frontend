import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'profile_edit_state.dart';

part 'profile_edit_cubit.freezed.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final profileRepo = getIt.get<ProfileRepo>();
  final imageService = getIt.get<ImageService>();

  ProfileEditCubit() : super(const ProfileEditState.initial()) {
    fetchCurrentProfile();
  }

  Future<void> fetchCurrentProfile() async {
    final currentProfile = await profileRepo.fetchUserProfile();
    switch (currentProfile) {
      case Success<PeopleCardModel>():
        emitNewState(state.copyWith(previewProfileModel: currentProfile.data));
      case Failure<PeopleCardModel>():
        emitNewState(
          state.copyWith(error: "No profile data found, please login again."),
        );
    }
  }

  Future<void> updateProfile(PeopleCardModel updatedModel) async {}

  Future<void> uploadMedia() async {}

  Future<void> deleteMedia(List<String> deletedFilesNumber) async {}

  Future<void> fetchAllPaymentHistory() async {}

  void updateRelationshipGoal(String newGoal) {}

  void updatePronouns(String newPronoun) {}

  void updateInterests(List<String> newInterests) {}

  void updateBio(String newBio) {}

  void updateOccupation(String newOccupation) {}

  void updateEducation(String newEducation) {}

  void updateHeight(String newHeight) {}

  void updateWorkoutHabits(String newWorkoutHabits) {}

  void updateSmokingHabits(String newSmokingHabits) {}

  void updateDrinkingHabits(String newDrinkingHabits) {}

  void emitNewState(ProfileEditState newState) {
    emit(newState);
  }

  Future<void> onPickImage() async {
    final pickedImages = await imageService.pickImages();
    // emitNewState(
    //   state.copyWith(
    //     uploadedFilePaths: pickedImages.map((image) => image.file).toList(),
    //   ),
    // );
    // updateProfileLocally();
  }

  void removeImageAt(int index) {
    // final currentImagesList = state.uploadedFilePaths;
    // currentImagesList.removeAt(index);
    // emitNewState(
    //   state.copyWith(
    //     uploadedFilePaths: currentImagesList,
    //   ),
    // );
    // updateProfileLocally();
  }
}
