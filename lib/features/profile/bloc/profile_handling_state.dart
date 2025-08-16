part of 'profile_handling_cubit.dart';

@freezed
class ProfileHandlingState with _$ProfileHandlingState {
  const factory ProfileHandlingState.initial({
    @Default(null) PeopleCardModel? previewProfileModel,
    @Default(null) ProfileMembershipEntity? membershipEntity,

    @Default("") String error,
    @Default(false) bool isLoading,
  }) = _Initial;
}
