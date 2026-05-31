import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/profile/bloc/edit/image_slot.dart';
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
        final profileModel = currentProfile.data;
        final slots = List.generate(9, (i) {
          final slotIndex = i + 1;
          return i < profileModel.pictureUrlList.length
              ? ImageSlot.existing(slotIndex, profileModel.pictureUrlList[i])
              : ImageSlot.empty(slotIndex);
        });
        emitNewState(
          state.copyWith(
            previewProfileModel: profileModel,
            isLoading: false,
            imageSlots: slots,
          ),
        );
        break;
      case Failure<PeopleCardModel>():
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

  Future<void> selectImageForSlot(int slotIndex) async {
    final imageData = await imageService.pickAndCompressForSlot(slotIndex);
    if (imageData?.file == null) return;

    final updatedSlots = List<ImageSlot>.from(state.imageSlots);
    updatedSlots[slotIndex - 1] = ImageSlot.local(slotIndex, imageData!.file!);
    emitNewState(state.copyWith(imageSlots: updatedSlots));
  }

  Future<void> publishChanges() async {
    final hasNewImages =
        state.imageSlots.any((s) => s.status == ImageSlotStatus.newLocal);

    if (hasNewImages && state.isProfileDataChanged) {
      Future.wait([uploadMedia(), updateProfile()]).then((_) {
        getUserProfile();
      }).onError((error, _) {
        emitNewState(state.copyWith(
          isLoading: false,
          error: "Not able to perform the required actions.",
        ));
      });
      return;
    }

    if (hasNewImages) {
      uploadMedia().then((_) => getUserProfile());
      return;
    }

    if (state.isProfileDataChanged) {
      updateProfile().then((_) => getUserProfile());
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
            isLoading: false, error: "Not able to update profile."));
        break;
    }
  }

  Future<void> updateProfileLocally(PeopleCardModel updatedModel) async {
    emitNewState(state.copyWith(isProfileDataChanged: true));
    await profileRepo.updateProfileData(updatedModel);
  }

  Future<void> uploadMedia() async {
    emitNewState(state.copyWith(isLoading: true));
    final newLocalFiles = state.imageSlots
        .where((s) =>
            s.status == ImageSlotStatus.newLocal && s.localFile != null)
        .map((s) => s.localFile!)
        .toList();

    final imagesResponse = await profileRepo.updateMedia(newLocalFiles);
    switch (imagesResponse) {
      case Success<void>():
        emitNewState(state.copyWith(isLoading: false));
        clearProfileDirectory();
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
            isLoading: false, error: "Not able to upload Media."));
        break;
    }
  }

  void updateRelationshipGoal(String newGoal) {
    final updatedModel = state.previewProfileModel?.copyWith(lookingFor: newGoal);
    emitNewState(state.copyWith(previewProfileModel: updatedModel));
    if (updatedModel != null) updateProfileLocally(updatedModel);
  }

  void updatePronouns(String newPronoun) {}

  void updateInterests(List<String> newInterests) {}

  void updateBio(String newBio) {
    final updatedModel = state.previewProfileModel?.copyWith(bio: newBio);
    if (updatedModel != null) updateProfileLocally(updatedModel);
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
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void updateEducation(String newEducation) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("education", (_) => newEducation);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void updateHeight(String newHeight) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("height", (_) => newHeight);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void updateWorkoutHabits(String newWorkoutHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("workout", (_) => newWorkoutHabits);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void updateSmokingHabits(String newSmokingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("smoking", (_) => newSmokingHabits);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void updateDrinkingHabits(String newDrinkingHabits) {
    final currentAboutMap = state.previewProfileModel?.about;
    currentAboutMap?.update("drinking", (_) => newDrinkingHabits);
    final updatedProfile =
        state.previewProfileModel?.copyWith(about: currentAboutMap);
    if (updatedProfile != null) {
      updateProfileLocally(updatedProfile);
      emitNewState(state.copyWith(previewProfileModel: updatedProfile));
    }
  }

  void emitNewState(ProfileEditState newState) {
    emit(newState);
  }

  void clearProfileDirectory() async {
    await imageService.clearProfileImagesDirectory();
  }
}
