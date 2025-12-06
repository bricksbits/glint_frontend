part of 'on_boarding_cubit.dart';

@freezed
class OnBoardingState with _$OnBoardingState {
  const factory OnBoardingState.initial({
    @Default(null) RegisterUserRequest? currentState,
    @Default(OnBoardingCompletedTill.NOT_STARTED) OnBoardingCompletedTill onBoardingStatus,
    @Default("") String error,
    @Default([]) List<File?> uploadedFilePaths,
    @Default(null) String? currentDestination,
    @Default(false) bool isLoading,
    bool? isLocationLoading,
    bool? locationPermissionDenied,
  }) = _Initial;
}

enum OnBoardingCompletedTill {
  NOT_STARTED,
  NAME_PROVIDED,
  AGE_CALCULATED,
  GENDER_SELECTED,
  CHOICE_OF_GENDER_SELECTED,
  IMAGES_SELECTED,
  PRONOUNS_DONE,
  INTERESTS_DONE,
  BIO_DONE,
  COMPLETED,
}
