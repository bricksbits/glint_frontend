part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial({
    @Default(null) PeopleCardModel? previewProfileModel,
    @Default("") String error,
    @Default(true) bool isLoading,
  }) = _Initial;
}
