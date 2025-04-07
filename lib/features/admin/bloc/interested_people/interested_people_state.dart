part of 'interested_people_bloc.dart';

@freezed
class InterestedPeopleState with _$InterestedPeopleState {
  const factory InterestedPeopleState.initial({
    @Default("") String eventName,
    @Default("") String eventId,
    @Default("") String eventAddress,
    @Default("") String eventThumbnail,
    @Default("") String eventDate,
    @Default("") String eventTime,
    @Default("") String eventStatus,
    @Default("") String totalInterestedPeopleCount,
    @Default([]) List<String> interestedPeople,
    @Default(false) bool loading,
  }) = _Initial;
}
