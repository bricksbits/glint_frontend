part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial({
    @Default(null) PeopleCardModel? previewProfileModel,
    @Default("") String error,
    @Default(true) bool isLoading,
    @Default(false) bool isProfileDataChanged,
    @Default([]) List<ImageSlot> imageSlots,
    @Default(true) bool refetchProfileData,
  }) = _Initial;
}
