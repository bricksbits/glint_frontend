part of 'ticket_bought_bloc.dart';

@freezed
class TicketBoughtState with _$TicketBoughtState {
  const factory TicketBoughtState.initial({
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
