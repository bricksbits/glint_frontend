part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial({
    @Default(null) PeopleCardModel? previewProfileModel,
    @Default("") String error,
    @Default(true) bool isLoading,
    @Default(false) bool isNewImagesUploaded,
    @Default(false) bool isProfileDataChanged,
    @Default([]) List<File?> newlyUploadedImages,
    @Default(true) bool refetchProfileData,
    @Default(0) int currentProfileImageSize,
  }) = _Initial;
}
