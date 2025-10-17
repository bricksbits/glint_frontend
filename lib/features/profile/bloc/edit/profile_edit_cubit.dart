import 'dart:io';

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
        emitNewState(
          state.copyWith(
              previewProfileModel: currentProfile.data, isLoading: false),
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

  Future<void> publishChanges() async {
    if (state.isNewImagesUploaded && state.newlyUploadedImages.isNotEmpty) {
      uploadMedia();
    }

    if (state.isProfileDataChanged && !state.isNewImagesUploaded) {
      updateProfile();
    }

    if (state.isNewImagesUploaded &&
        state.newlyUploadedImages.isNotEmpty &&
        state.isProfileDataChanged) {
      Future.wait([uploadMedia(), updateProfile()]).then((_) {
        emitNewState(state.copyWith(
          isLoading: false,
          isNewImagesUploaded: false,
          newlyUploadedImages: [],
          isProfileDataChanged: false,
        ));
      }).onError((error, st) {
        emitNewState(state.copyWith(
            isLoading: false,
            error: "Not able to perform the required actions,"));
      });
    }
  }

  Future<void> updateProfile() async {
    emitNewState(state.copyWith(isLoading: true));
    final profileUpdateResponse = await profileRepo.updateProfile();
    switch (profileUpdateResponse) {
      case Success<void>():
        emitNewState(state.copyWith(
          isLoading: false,
          isProfileDataChanged: false,
        ));
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
            isLoading: false, error: "Not able to update profile,"));
        break;
    }
  }

  Future<void> updateProfileLocally(PeopleCardModel updatedModel) async {
    emitNewState(state.copyWith(
      isProfileDataChanged: true,
    ));
    await profileRepo.updateProfileData(updatedModel);
  }

  Future<void> uploadMedia() async {
    emitNewState(state.copyWith(isLoading: true));
    final imagesResponse = await profileRepo.updateMedia();
    switch (imagesResponse) {
      case Success<void>():
        emitNewState(state.copyWith(
          isLoading: false,
        ));
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
            isLoading: false, error: "Not able to upload Media,"));
        break;
    }
  }

  Future<void> deleteMedia(List<String> deletedFilesNumber) async {}

  Future<void> fetchAllPaymentHistory() async {}

  void updateRelationshipGoal(String newGoal) {}

  void updatePronouns(String newPronoun) {}

  void updateInterests(List<String> newInterests) {}

  void updateBio(String newBio) {
    final updatedModelWithBio = state.previewProfileModel?.copyWith(
      bio: newBio,
    );
    if (updatedModelWithBio != null) {
      updateProfileLocally(updatedModelWithBio);
    }
  }

  void updateOccupation(String newOccupation) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("occupation", (_) => newOccupation);
    final updatedProfile = state.previewProfileModel?.copyWith(
      about: currentAboutMap,
      occupation: newOccupation,
    );
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updatedProfile,
        ),
      );
    }
  }

  void updateEducation(String newEducation) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("education", (_) => newEducation);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updatedProfile,
        ),
      );
    }
  }

  void updateHeight(String newHeight) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("height", (_) => newHeight);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updatedProfile,
        ),
      );
    }
  }

  void updateWorkoutHabits(String newWorkoutHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("workout", (_) => newWorkoutHabits);
    final updateProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updateProfile != null) {
      updateProfileLocally(updateProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updateProfile,
        ),
      );
    }
  }

  void updateSmokingHabits(String newSmokingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("smoking", (_) => newSmokingHabits);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updatedProfile,
        ),
      );
    }
  }

  void updateDrinkingHabits(String newDrinkingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("drinking", (_) => newDrinkingHabits);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(
        state.copyWith(
          previewProfileModel: updatedProfile,
        ),
      );
    }
  }

  void emitNewState(ProfileEditState newState) {
    emit(newState);
  }

  Future<void> onPickImage() async {
    final pickedImages = await imageService.pickImages();
    emitNewState(
      state.copyWith(
        newlyUploadedImages: pickedImages.map((image) => image.file).toList(),
        isNewImagesUploaded: true,
      ),
    );
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
