import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/services/location_permission_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'on_boarding_cubit.freezed.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepo boardingRepo = getIt.get<OnBoardingRepo>();
  final ImageService imageService = getIt.get<ImageService>();

  OnBoardingCubit() : super(const OnBoardingState.initial()) {
    getLatestUpdatedState().then((currentBoardingState) {
      getCurrentBoardingStatus(currentBoardingState);
    });
    initializePersonWithAllDetails();
  }

  /// This will be called whenever the user lands to a new screen/state
  Future<void> setUpLastBoardingState(OnBoardingCompletedTill state) async {
    await boardingRepo.setupCurrentBoardingState(state);
  }

  /// This method will be called when create account is clicked
  /// And will decide which screen to display
  void getCurrentBoardingStatus(OnBoardingCompletedTill currentStatus) {
    debugLogger("Boarding State", currentStatus.name);
    switch (currentStatus) {
      case OnBoardingCompletedTill.NOT_STARTED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.name.name,
        ));
        break;
      case OnBoardingCompletedTill.NAME_PROVIDED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.dob.name,
        ));
        break;
      case OnBoardingCompletedTill.AGE_CALCULATED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.gender.name,
        ));
        break;
      case OnBoardingCompletedTill.GENDER_SELECTED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.interestedGender.name,
        ));
        break;
      case OnBoardingCompletedTill.CHOICE_OF_GENDER_SELECTED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.media.name,
        ));
        break;
      case OnBoardingCompletedTill.IMAGES_SELECTED:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.pronouns.name,
        ));
        break;
      case OnBoardingCompletedTill.PRONOUNS_DONE:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.interests.name,
        ));
        break;
      case OnBoardingCompletedTill.INTERESTS_DONE:
        emitNewState(state.copyWith(
          currentDestination: GlintBoardingRoutes.bio.name,
        ));
        break;
      case OnBoardingCompletedTill.COMPLETED:
        //Todo: Update this Logic as per Bio screen only
        emitNewState(state.copyWith(
          currentDestination: GlintMainRoutes.register.name,
        ));
        break;
    }
  }

  // Helper method to get the current RegisterUserModel,
  RegisterUserRequest? _getCurrentRegisterUserState() {
    return state.mapOrNull(
      initial: (s) => s.currentState,
    );
  }

  String? get currentName => _getCurrentRegisterUserState()?.username;

  String? get currentAge =>
      _getCurrentRegisterUserState()?.dateOfBirthWithDateFormat;

  String? get currentDesignation => _getCurrentRegisterUserState()?.occupation;

  String? get currentBio => _getCurrentRegisterUserState()?.bio;

  String? get currentLookingFor =>
      _getCurrentRegisterUserState()?.relationShipGoals;

  List<String>? get currentInterests =>
      _getCurrentRegisterUserState()?.interests;

  String? get currentGender => _getCurrentRegisterUserState()?.gender;

  String? get currentGenderPreferences =>
      _getCurrentRegisterUserState()?.genderPreference;

  String? get currentHeight => _getCurrentRegisterUserState()?.height;

  String? get currentOccupation => _getCurrentRegisterUserState()?.occupation;

  String? get currentEducation => _getCurrentRegisterUserState()?.education;

  String? get currentWorkingHabit =>
      _getCurrentRegisterUserState()?.workoutHabit;

  String? get currentDrinkingHabit =>
      _getCurrentRegisterUserState()?.drinkingHabit;

  String? get currentSmokingHabit =>
      _getCurrentRegisterUserState()?.smokingHabit;

  void setGender(String gender) {
    emit(
      state.copyWith(
          currentState:
              _getCurrentRegisterUserState()?.copyWith(gender: gender)),
    );
    updateProfileLocally();
  }

  void setGenderPreferences(String genderPreferences) {
    emit(
      state.copyWith(
          currentState: _getCurrentRegisterUserState()
              ?.copyWith(genderPreference: genderPreferences)),
    );
    updateProfileLocally();
  }

  void setHeight(String height) {
    emit(
      state.copyWith(
          currentState: _getCurrentRegisterUserState()?.copyWith(
        height: height,
      )),
    );
    updateProfileLocally();
  }

  void setOccupation(String occupation) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          occupation: occupation,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setEducation(String education) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          education: education,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setWorkingHabit(String workingHabit) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          workoutHabit: workingHabit,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setDrinkingHabit(String drinkingHabit) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          drinkingHabit: drinkingHabit,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setSmokingHabit(String smokingHabit) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          smokingHabit: smokingHabit,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setName(String name) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          username: name,
        ),
      ),
    );
    if (name.length > 3) {
      updateProfileLocally();
    }
  }

  void setAge(
    int age,
    String selectedDate,
  ) {
    if (age >= 18) {
      emit(
        state.copyWith(
          currentState: _getCurrentRegisterUserState()?.copyWith(
            calculatedAge: age.toString(),
            dob: selectedDate,
          ),
        ),
      );
      updateProfileLocally();
    } else {
      emit(
        state.copyWith(
          error: "You are to young for dating, :D",
        ),
      );
    }
  }

  void setDesignation(String designation) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          occupation: designation,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setBio(String bio) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          bio: bio,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setLookingFor(String lookingFor) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          relationShipGoals: lookingFor,
        ),
      ),
    );
    updateProfileLocally();
  }

  void setInterests(List<String> interests) {
    emit(
      state.copyWith(
        currentState: _getCurrentRegisterUserState()?.copyWith(
          interests: List.from(interests),
        ),
      ),
    );
    updateProfileLocally();
  }

  Future<void> onPickImage() async {
    final pickedImages = await imageService.pickImages();
    emitNewState(
      state.copyWith(
        uploadedFilePaths: pickedImages.map((image) => image.file).toList(),
      ),
    );
    updateProfileLocally();
  }

  void removeImageAt(int index) {
    final currentImagesList = state.uploadedFilePaths;
    currentImagesList.removeAt(index);
    emitNewState(
      state.copyWith(
        uploadedFilePaths: currentImagesList,
      ),
    );
    updateProfileLocally();
  }

  Future<void> updateProfileLocally() async {
    final getUpdateProfile = _getCurrentRegisterUserState();
    if (getUpdateProfile != null) {
      boardingRepo.updateUserDetailsLocally(getUpdateProfile);
    }
  }

  Future<OnBoardingCompletedTill> getLatestUpdatedState() async {
    final currentStage = await boardingRepo.getCurrentBoardingState();
    emitNewState(
      state.copyWith(onBoardingStatus: currentStage),
    );
    return currentStage;
  }

  // Helper for when currentState is null
  void _handleNullCurrentState(String methodName) {
    // You can choose to log this, throw an error, or emit a specific error state
    print("Warning: $methodName called when currentState is null.");
    emit(state.copyWith(
        error: "Cannot update $methodName: PeopleUiModel is null."));
  }

  Future<void> insertFakeUserInitially() async {
    var currentUser = _getCurrentRegisterUserState();
    if (currentUser != null) {
      await boardingRepo.insertUser(currentUser);
    }
  }

  Future<void> initializePersonWithAllDetails() async {
    final currentProgress = await boardingRepo.getCurrentUserState();
    switch (currentProgress) {
      case Success<RegisterUserRequest>():
        final currentUser = currentProgress.data;
        debugLogger("OnBoardingCubit", currentUser.toString());
        emitNewState(
          state.copyWith(
            currentState: currentUser,
          ),
        );
      case Failure<RegisterUserRequest>():
        var tempUser = RegisterUserRequest(
          NEW_ON_BOARD_USER_ID,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        );
        emitNewState(
          state.copyWith(
            currentState: tempUser,
            onBoardingStatus: OnBoardingCompletedTill.NOT_STARTED,
          ),
        );
        insertFakeUserInitially();
    }
  }

  Future<void> enableLocationAndCompleteOnboarding() async {
    emit(state.copyWith(
        isLocationLoading: true, locationPermissionDenied: false));

    final permissionService = getIt<LocationPermissionService>();
    final sharedPrefHelper = getIt<AsyncEncryptedSharedPreferenceHelper>();

    final isGranted = await permissionService.requestPermission();

    if (!isGranted) {
      emit(state.copyWith(
        isLocationLoading: false,
        locationPermissionDenied: true,
      ));
      return;
    }

    final position = await permissionService.getCurrentLocation();

    if (position != null) {
      await sharedPrefHelper.saveString(
        SharedPreferenceKeys.userLatitudeKey,
        position.latitude.toString(),
      );
      await sharedPrefHelper.saveString(
        SharedPreferenceKeys.userLongitudeKey,
        position.longitude.toString(),
      );

      await setUpLastBoardingState(OnBoardingCompletedTill.COMPLETED);
      emit(state.copyWith(
        isLocationLoading: false,
        onBoardingStatus: OnBoardingCompletedTill.COMPLETED,
      ));
    } else {
      emit(state.copyWith(
        isLocationLoading: false,
        error: 'Unable to fetch location',
      ));
    }
  }

  bool validateIfImageProvidedOrNot() {
    if (state.uploadedFilePaths.isEmpty) {
      emitNewState(state.copyWith(error: "Please Select atleast one image."));
      return false;
    }
    return true;
  }

  bool validateInterestCounts() {
    if (state.currentState?.interests != null &&
        state.currentState!.interests!.isNotEmpty) {
      if (state.currentState!.interests!.length < 5) {
        emitNewState(state.copyWith(
            error:
                "Please select more ${5 - state.currentState!.interests!.length} interest for better matching."));
        return false;
      } else {
        return true;
      }
    } else {
      emitNewState(state.copyWith(
          error: "Please select around 5 interests for better matching."));
      return false;
    }
  }

  bool validatePersonalInformation() {
    if (state.currentState?.height == null) {
      emitNewState(state.copyWith(error: "Height Missing,"));
      return false;
    }

    if (state.currentState?.education == null) {
      emitNewState(state.copyWith(error: "Education Missing,"));
      return false;
    }

    if (state.currentState?.occupation == null &&
        state.currentState!.occupation!.isNotEmpty) {
      emitNewState(state.copyWith(error: "Occupation leads to better matches"));
      return false;
    }

    if (state.currentState?.smokingHabit == null) {
      emitNewState(state.copyWith(error: "Smoking Habit Missing,"));
      return false;
    }

    if (state.currentState?.drinkingHabit == null) {
      emitNewState(state.copyWith(error: "Drinking Habit Missing,"));
      return false;
    }

    if (state.currentState?.workoutHabit == null) {
      emitNewState(state.copyWith(error: "Workout Habit Missing,"));
      return false;
    }

    if (state.currentState?.bio == null &&
        state.currentState!.bio!.isNotEmpty) {
      emitNewState(state.copyWith(
          error: "Bio tells more about you, can lead to better match,"));
      return false;
    }

    return true;
  }

  bool validateIfRelationGoalsProvidedOrNot() {
    if (state.currentState?.relationShipGoals == null) {
      emitNewState(state.copyWith(error: "Tell us what you are looking for?"));
      return false;
    }

    return true;
  }

  void emitNewState(OnBoardingState newState) {
    emit(newState);
  }
}
