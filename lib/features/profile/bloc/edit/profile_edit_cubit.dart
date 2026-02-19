import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'profile_edit_state.dart';

part 'profile_edit_cubit.freezed.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final profileRepo = getIt.get<ProfileRepo>();
  final imageService = getIt.get<ImageService>();

  ProfileEditCubit() : super(const ProfileEditState.initial()) {
    fetchCurrentProfile();
  }

  final String logPrefix = "ProfileCubit";

  Future<void> fetchCurrentProfile() async {
    final currentProfile = await profileRepo.fetchUserProfile();
    switch (currentProfile) {
      case Success<PeopleCardModel>():
        emitNewState(
          state.copyWith(
            previewProfileModel: currentProfile.data,
            isLoading: false,
            currentProfileImageSize: currentProfile.data.pictureUrlList.length,
          ),
        );
        break;
      case Failure<PeopleCardModel>():
        // A Weak mechanism to close the recursion calls,
        if (state.refetchProfileData) {
          debugLogger(logPrefix, "NoProfile Data found, re-fetching data");
          getUserProfile();
          emitNewState(state.copyWith(refetchProfileData: false));
        }
        emitNewState(
          state.copyWith(
            error: "No profile data found, Fetching data again.",
            isLoading: false,
          ),
        );
        break;
    }
  }

  Future<void> getUserProfile() async {
    final itsMeResponse = await profileRepo.getAndCacheUserProfile();
    switch (itsMeResponse) {
      case Success<void>():
        fetchCurrentProfile();
        break;
      case Failure<void>():
        emitNewState(
          state.copyWith(
            error: "Server Went down, can't fetch profile currently",
            isLoading: false,
          ),
        );
        break;
    }
  }

  Future<void> publishChanges() async {
    if (state.isNewImagesUploaded && state.newlyUploadedImages.isNotEmpty) {
      uploadMedia().then((_) {
        getUserProfile();
      });
    }

    if (state.isProfileDataChanged && !state.isNewImagesUploaded) {
      updateProfile().then((_) {
        getUserProfile();
      });
    }

    if (state.isNewImagesUploaded &&
        state.newlyUploadedImages.isNotEmpty &&
        state.isProfileDataChanged) {
      Future.wait([uploadMedia(), updateProfile()]).then((_) {
        getUserProfile();
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
        clearProfileDirectory();
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
            isLoading: false, error: "Not able to upload Media,"));
        break;
    }
  }

  void updateRelationshipGoal(String newGoal) {
    final updatedModelWithRelationShipGoal =
        state.previewProfileModel?.copyWith(
      lookingFor: newGoal,
    );
    emitNewState(
        state.copyWith(previewProfileModel: updatedModelWithRelationShipGoal));
    if (updatedModelWithRelationShipGoal != null) {
      updateProfileLocally(updatedModelWithRelationShipGoal);
    }
  }

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
    final maxCountForImages = state.currentProfileImageSize;
    final pickedImages = await imageService.pickImages(
      currentImageCount: maxCountForImages,
    );
    final emptyFilesPadding = List<File?>.filled(maxCountForImages, null);
    final newFiles = pickedImages.map((img) => img.file).toList();

    emitNewState(
      state.copyWith(
        newlyUploadedImages: maxCountForImages != 0
            ? [
                ...emptyFilesPadding,
                ...newFiles,
              ]
            : newFiles,
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

  void clearProfileDirectory() async {
    await imageService.clearProfileImagesDirectory();
  }
}
