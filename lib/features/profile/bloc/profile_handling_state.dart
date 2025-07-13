part of 'profile_handling_cubit.dart';

@freezed
class ProfileHandlingState with _$ProfileHandlingState {
  const factory ProfileHandlingState.initial({
    @Default(null) PeopleCardModel previewProfileModel,
  }) = _Initial;
}
