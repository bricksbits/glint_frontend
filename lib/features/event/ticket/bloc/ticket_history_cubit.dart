import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/event/fetch_ticket_history_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/common/pagination_params.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';

part 'ticket_history_state.dart';

part 'ticket_history_cubit.freezed.dart';

class TicketHistoryCubit extends Cubit<TicketHistoryState> {
  TicketHistoryCubit() : super(const TicketHistoryState()) {
    loadInitial();
  }

  final _useCase = getIt.get<FetchTicketHistoryUseCase>();

  Future<void> loadInitial() async {
    emit(state.copyWith(
      isLoading: true,
      error: null,
      tickets: [],
      offset: 0,
      hasMore: true,
    ));

    _useCase.perform(
      (tickets) {
        final list = tickets ?? [];
        emit(state.copyWith(
          isLoading: false,
          tickets: list,
          offset: list.length,
          hasMore: list.isNotEmpty,
        ));
      },
      (error) {
        emit(state.copyWith(
          isLoading: false,
          error: error?.toString() ?? 'Failed to load tickets',
        ));
      },
      () {},
      const PaginationParams(offset: 0),
    );
  }

  /// Appends the next page. Guards against duplicate calls and end-of-list.
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoadingMore: true));

    _useCase.perform(
      (tickets) {
        final incoming = tickets ?? [];
        final merged = [...state.tickets, ...incoming];
        emit(state.copyWith(
          tickets: merged,
          offset: merged.length,
          isLoadingMore: false,
          // Empty response from the server marks the end of the list.
          hasMore: incoming.isNotEmpty,
        ));
      },
      (error) {
        emit(state.copyWith(
          isLoadingMore: false,
          error: error?.toString() ?? 'Failed to load more tickets',
        ));
      },
      () {},
      PaginationParams(offset: state.offset),
    );
  }
}
