part of 'ticket_history_cubit.dart';

@freezed
class TicketHistoryState with _$TicketHistoryState {
  const factory TicketHistoryState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<EventTicketHistoryDomainModel> tickets,
    @Default(0) int offset,
    @Default(true) bool hasMore,
    @Default(null) String? error,
  }) = _TicketHistoryState;
}
