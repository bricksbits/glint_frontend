part of 'profile_preview_cubit.dart';

@freezed
class ProfilePreviewState with _$ProfilePreviewState {
  const factory ProfilePreviewState.initial({
    @Default(null) PeopleCardModel? previewProfileModel,
    @Default("") String error,
    @Default(true) bool isLoading,
  }) = _Initial;
}
