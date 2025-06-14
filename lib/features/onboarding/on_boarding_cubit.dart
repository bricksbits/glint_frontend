import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';
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
    setUpTempUserIdForCurrentUser();
  }

  // Future<void> getCurrentBoardingStatus() async {
  //   final currentStatus = await authenticationRepo.getOnBoardingStatusTillNow();
  //   switch (currentStatus) {
  //     case OnBoardingCompletedTill.NOT_STARTED:
  //       emitNewState(state.copyWith(
  //           onBoarding
  //       ));
  //     case OnBoardingCompletedTill.NAME_PROVIDED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.AGE_CALCULATED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.GENDER_SELECTED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.CHOICE_OF_GENDER_SELECTED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.IMAGES_SELECTED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.PRONOUNS_DONE:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.INTERESTS_DONE:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //     case OnBoardingCompletedTill.COMPLETED:
  //     // TODO: Handle this case.
  //       throw UnimplementedError();
  //   }
  // }

  void setUpTempUserIdForCurrentUser() {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(
            state.copyWith(
              currentState: currentState.copyWith(userId: NEW_ON_BOARD_USER_ID),
            ),
          );
        } else {
          _handleNullCurrentState("USER ID");
        }
      },
    );
  }

  // Helper method to get the current PeopleUiModel, handles null
  PeopleUiModel? _getCurrentPeopleUiModel() {
    return state.mapOrNull(
      initial: (s) => s.currentState,
    );
  }

  // --- Getters for PeopleUiModel properties ---
  String? get currentUserId => _getCurrentPeopleUiModel()?.userId;

  String? get currentName => _getCurrentPeopleUiModel()?.name;

  String? get currentAge => _getCurrentPeopleUiModel()?.age;

  String? get currentDistanceAway => _getCurrentPeopleUiModel()?.distanceAway;

  String? get currentViews => _getCurrentPeopleUiModel()?.profileViews;

  String? get currentDesignation => _getCurrentPeopleUiModel()?.designation;

  List<String>? get currentAbout => _getCurrentPeopleUiModel()?.about;

  String? get currentBio => _getCurrentPeopleUiModel()?.bio;

  List<String>? get currentLookingFor => _getCurrentPeopleUiModel()?.lookingFor;

  String? get currentLocation => _getCurrentPeopleUiModel()?.location;

  List<String>? get currentInterests => _getCurrentPeopleUiModel()?.interests;

  List<String>? get currentImages => _getCurrentPeopleUiModel()?.images;

  String? get currentGender => _getCurrentPeopleUiModel()?.gender;

  String? get currentGenderPreferences =>
      _getCurrentPeopleUiModel()?.genderPreference;

  String? get currentHeight => _getCurrentPeopleUiModel()?.height;

  String? get currentOccupation => _getCurrentPeopleUiModel()?.occupation;

  String? get currentEducation => _getCurrentPeopleUiModel()?.education;

  String? get currentWorkingHabit => _getCurrentPeopleUiModel()?.workoutHabit;

  String? get currentDrinkingHabit => _getCurrentPeopleUiModel()?.drinkingHabit;

  String? get currentSmokingHabit => _getCurrentPeopleUiModel()?.smokingHabit;

  String? get currentProfileLikes => _getCurrentPeopleUiModel()?.profileLikes;

  void setGender(String gender) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(height: height)));
        } else {
          _handleNullCurrentState("setHeight");
        }
      },
    );
  }

  void setOccupation(String occupation) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
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
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(smokingHabit: smokingHabit)));
        } else {
          _handleNullCurrentState("setSmokingHabit");
        }
      },
    );
  }

  void setProfileLikes(String profileLikes) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(profileLikes: profileLikes)));
        } else {
          _handleNullCurrentState("setProfileLikes");
        }
      },
    );
  }

  void setName(String name) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          if (name.isNotEmpty) {
            emit(state.copyWith(
                currentState: currentState.copyWith(name: name)));
          }
        } else {
          _handleNullCurrentState("setName");
        }
      },
    );
  }

  void setAge(String age) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(currentState: currentState.copyWith(age: age)));
        } else {
          _handleNullCurrentState("setAge");
        }
      },
    );
  }

  void setDistanceAway(String distanceAway) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(distanceAway: distanceAway)));
        } else {
          _handleNullCurrentState("setDistanceAway");
        }
      },
    );
  }

  void setViews(String views) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(profileViews: views)));
        } else {
          _handleNullCurrentState("setViews");
        }
      },
    );
  }

  void setDesignation(String designation) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(designation: designation)));
        } else {
          _handleNullCurrentState("setDesignation");
        }
      },
    );
  }

  void setAbout(List<String> about) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          // IMPORTANT: When setting a list, always provide a *new* list instance
          // to ensure immutability and trigger proper state updates.
          emit(state.copyWith(
              currentState: currentState.copyWith(about: List.from(about))));
        } else {
          _handleNullCurrentState("setAbout");
        }
      },
    );
  }

  void setBio(String bio) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(currentState: currentState.copyWith(bio: bio)));
        } else {
          _handleNullCurrentState("setBio");
        }
      },
    );
  }

  void setLookingFor(List<String> lookingFor) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState:
                  currentState.copyWith(lookingFor: List.from(lookingFor))));
        } else {
          _handleNullCurrentState("setLookingFor");
        }
      },
    );
  }

  void setPronouns(String pronouns) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(gender: pronouns)));
        } else {
          _handleNullCurrentState("setLookingFor");
        }
      },
    );
  }

  void setLocation(String location) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(location: location)));
        } else {
          _handleNullCurrentState("setLocation");
        }
      },
    );
  }

  void setInterests(List<String> interests) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
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
    final currentImagesList = state.currentState?.images;
    currentImagesList?.removeAt(index);
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(images: currentImagesList)));
        } else {
          _handleNullCurrentState("setImages");
        }
      },
    );
  }

  void setImages(List<String?> images) {
    state.when(
      initial: (currentState, onBoardingStatus, error) {
        if (currentState != null) {
          emit(state.copyWith(
              currentState: currentState.copyWith(images: List.from(images))));
        } else {
          _handleNullCurrentState("setImages");
        }
      },
    );
  }

  Future<void> updateProfileLocally() async {
    final getUpdateProfile = _getCurrentPeopleUiModel();
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
  void initializePersonWithAllDetails() {
    emit(
      state.copyWith(
        currentState: PeopleUiModel(
          "test_user_id",
          "Bricks Bits",
          "1",
          "0 km",
          "250",
          "Software Company",
          ["Loves art", "Travel enthusiast"],
          "Creative soul seeking inspiration.",
          ["Long-term relationship", "Friendship"],
          "Bhilai",
          ["Photography", "Cooking", "Yoga"],
          [],
          "BOT",
          "BOT",
          "5'6",
          "Software Developer",
          "Master's Degree",
          "Morning Person",
          "Social Drinker",
          "Non-Smoker",
          "Dogs, Beaches, Sunsets",
        ),
        onBoardingStatus: OnBoardingCompletedTill.NOT_STARTED,
      ),
    );
  }
}
