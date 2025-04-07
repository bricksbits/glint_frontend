part of 'ticket_bought_bloc.dart';

@freezed
class TicketBoughtEvent with _$TicketBoughtEvent {
  const factory TicketBoughtEvent.started() = _Started;
}
