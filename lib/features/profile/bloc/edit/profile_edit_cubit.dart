import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/domain/business_logic/models/profile/profile_properties_enum.dart';
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

  Future<void> updateProfile(PeopleCardModel updatedModel) async {
    await profileRepo.updateProfileData(updatedModel);
  }

  Future<void> uploadMedia() async {}

  Future<void> deleteMedia(List<String> deletedFilesNumber) async {}

  Future<void> fetchAllPaymentHistory() async {}

  void updateRelationshipGoal(String newGoal) {}

  void updatePronouns(String newPronoun) {}

  void updateInterests(List<String> newInterests) {}

  void updateBio(String newBio) {
    final updatedModelWithBio =
        state.previewProfileModel?.copyWith(bio: newBio);
    if (updatedModelWithBio != null) {
      updateProfile(updatedModelWithBio);
    }
  }

  void updateOccupation(String newOccupation) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("occupation", (_) => newOccupation);
    final updatedAbout = state.previewProfileModel?.copyWith(
      about: currentAboutMap,
      occupation: newOccupation,
    );
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

  void updateEducation(String newEducation) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("education", (_) => newEducation);
    final updatedAbout =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

  void updateHeight(String newHeight) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("height", (_) => newHeight);
    final updatedAbout =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

  void updateWorkoutHabits(String newWorkoutHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("workout", (_) => newWorkoutHabits);
    final updatedAbout =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

  void updateSmokingHabits(String newSmokingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("smoking", (_) => newSmokingHabits);
    final updatedAbout =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

  void updateDrinkingHabits(String newDrinkingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("drinking", (_) => newDrinkingHabits);
    final updatedAbout =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedAbout != null) {
      updateProfile(updatedAbout);
    }
  }

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
