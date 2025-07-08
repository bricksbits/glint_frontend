part of 'event_base_cubit.dart';

@freezed
class EventBaseState with _$EventBaseState {
  const factory EventBaseState.initial({
    @Default(null) int? selectedEventId,
    @Default(true) bool isLoading,
    @Default([]) List<PeopleCardModel> selectedEventPeople,
    @Default([]) List<EventListDomainModel> allEvents,
    @Default([]) List<EventListDomainModel> hotEvents,
    @Default([]) List<EventListDomainModel> normalEvents,
    @Default("") String categorySelected,
    @Default("") String error,
  }) = _Initial;
}
