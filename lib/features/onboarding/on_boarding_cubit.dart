import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'on_boarding_state.dart';

part 'on_boarding_cubit.freezed.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepo boardingRepo = getIt.get<OnBoardingRepo>();
  final ImageService imageService = getIt.get<ImageService>();

  OnBoardingCubit() : super(const OnBoardingState.initial()) {
    initializePersonWithAllDetails();
  }

  /// This method will be called when create account is clicked
  /// And will decide which screen to display
  Future<void> getCurrentBoardingStatus() async {
    final currentStatus = await boardingRepo.getLastUpdateState();
    switch (currentStatus) {
      case OnBoardingCompletedTill.NOT_STARTED:
      case OnBoardingCompletedTill.NAME_PROVIDED:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.AGE_CALCULATED:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.GENDER_SELECTED:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.CHOICE_OF_GENDER_SELECTED:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.IMAGES_SELECTED:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.PRONOUNS_DONE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.INTERESTS_DONE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OnBoardingCompletedTill.COMPLETED:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  // void setUpTempUserIdForCurrentUser() {
  //   state.when(
  //     initial: (currentState, onBoardingStatus, error, uploadedFiles) {
  //       if (currentState != null) {
  //         emit(
  //           state.copyWith(
  //             currentState:
  //                 currentState.copyWith(tempUserId: NEW_ON_BOARD_USER_ID),
  //           ),
  //         );
  //       } else {
  //         _handleNullCurrentState("USER ID");
  //       }
  //     },
  //   );
  // }

  // Helper method to get the current PeopleUiModel, handles null
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
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(gender: gender)));
        } else {
          _handleNullCurrentState("setGender");
        }
      },
    );
  }

  void setGenderPreferences(String genderPreferences) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState:
                  currentState.copyWith(genderPreference: genderPreferences)));
        } else {
          _handleNullCurrentState("setGenderPreferences");
        }
      },
    );
  }

  void setHeight(String height) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(
            state.copyWith(
              currentState: currentState.copyWith(
                height: height,
              ),
            ),
          );
        } else {
          _handleNullCurrentState("setHeight");
        }
      },
    );
  }

  void setOccupation(String occupation) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(occupation: occupation)));
        } else {
          _handleNullCurrentState("setOccupation");
        }
      },
    );
  }

  void setEducation(String education) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(education: education)));
        } else {
          _handleNullCurrentState("setEducation");
        }
      },
    );
  }

  void setWorkingHabit(String workingHabit) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(workoutHabit: workingHabit)));
        } else {
          _handleNullCurrentState("setWorkingHabit");
        }
      },
    );
  }

  void setDrinkingHabit(String drinkingHabit) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState:
                  currentState.copyWith(drinkingHabit: drinkingHabit)));
        } else {
          _handleNullCurrentState("setDrinkingHabit");
        }
      },
    );
  }

  void setSmokingHabit(String smokingHabit) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(smokingHabit: smokingHabit)));
        } else {
          _handleNullCurrentState("setSmokingHabit");
        }
      },
    );
  }

  void setName(String name) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          if (name.isNotEmpty) {
            emit(state.copyWith(
                currentState: currentState.copyWith(username: name)));
          }
        } else {
          _handleNullCurrentState("setName");
        }
      },
    );
  }

  void setAge(String age) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(currentState: currentState.copyWith(dob: age)));
        } else {
          _handleNullCurrentState("setAge");
        }
      },
    );
  }

  void setDesignation(String designation) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(occupation: designation)));
        } else {
          _handleNullCurrentState("setDesignation");
        }
      },
    );
  }

  void setBio(String bio) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(currentState: currentState.copyWith(bio: bio)));
        } else {
          _handleNullCurrentState("setBio");
        }
      },
    );
  }

  void setLookingFor(String lookingFor) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState:
                  currentState.copyWith(relationShipGoals: lookingFor)));
        } else {
          _handleNullCurrentState("setLookingFor");
        }
      },
    );
  }

  void setInterests(List<String> interests) {
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState:
                  currentState.copyWith(interests: List.from(interests))));
        } else {
          _handleNullCurrentState("setInterests");
        }
      },
    );
  }

  Future<void> onPickImage() async {
    final pickedImages = await imageService.pickImages();
    final mappedToPaths = pickedImages.map((file) {
      if (file.file?.path != null) {
        return file.file!.path;
      }
    }).toList();

    setImages(mappedToPaths);
  }

  void removeImageAt(int index) {
    final currentImagesList = state.uploadedFilePaths;
    currentImagesList.removeAt(index);
    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (currentState != null) {
          emit(
            state.copyWith(
              uploadedFilePaths: currentImagesList,
            ),
          );
        } else {
          _handleNullCurrentState("setImages");
        }
      },
    );
  }

  void setImages(List<String?> images) {
    final filteredList = images
        .where((item) => item != null)
        .map((mapItem) => mapItem!)
        .toList();

    state.when(
      initial: (currentState, onBoardingStatus, error, uploadedFiles) {
        if (images.isNotEmpty) {
          emit(
            state.copyWith(uploadedFilePaths: filteredList),
          );
        } else {
          _handleNullCurrentState("setImages");
        }
      },
    );
  }

  Future<void> updateProfileLocally() async {
    final getUpdateProfile = _getCurrentRegisterUserState();
    if (getUpdateProfile != null) {
      boardingRepo.updateUserDetailsLocally(getUpdateProfile);
    }
  }

  Future<void> getLatestUpdatedState() async {
    final currentStage = await boardingRepo.getLastUpdateState();
    emit(state.copyWith(onBoardingStatus: currentStage));
  }

  Future<void> completeOnBoardingAndRegisterUser() async {
    final isUserRegistered = await boardingRepo.registerNewUser();
    switch (isUserRegistered) {
      case Success<void>():
        emit(
          state.copyWith(
            onBoardingStatus: OnBoardingCompletedTill.COMPLETED,
          ),
        );
      case Failure<void>():
        emit(state.copyWith(
            error:
                "Something Went Wrong, please check your internet, and try again."));
    }
  }

  // Helper for when currentState is null
  void _handleNullCurrentState(String methodName) {
    // You can choose to log this, throw an error, or emit a specific error state
    print("Warning: $methodName called when currentState is null.");
    emit(state.copyWith(
        error: "Cannot update $methodName: PeopleUiModel is null."));
  }

  //Todo: Fetch from the DB and Update the required fields
  Future<void> initializePersonWithAllDetails() async {
    final currentProgress = await boardingRepo.getLastUpdatedUser();
    switch (currentProgress) {
      case Success<RegisterUserRequest>():
        final currentUser = currentProgress.data;
        emitNewState(
          state.copyWith(
            currentState: currentUser,
            onBoardingStatus: OnBoardingCompletedTill.NOT_STARTED,
          ),
        );
      case Failure<RegisterUserRequest>():
        emitNewState(
          state.copyWith(
            currentState: RegisterUserRequest(
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
            ),
            onBoardingStatus: OnBoardingCompletedTill.NOT_STARTED,
          ),
        );
    }
  }

  void emitNewState(OnBoardingState newState) {
    emit(newState);
  }
}
