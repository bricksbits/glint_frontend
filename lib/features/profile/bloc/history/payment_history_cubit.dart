import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/response/payment/payment_history_response.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/payment/payment_history_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'payment_history_state.dart';

part 'payment_history_cubit.freezed.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final paymentRepo = getIt.get<PaymentRepo>();

  PaymentHistoryCubit() : super(const PaymentHistoryState.initial());

  Future<void> fetchHistory() async {
    emitNewState(state.copyWith(isLoading: true));
    final historyResult = await paymentRepo.fetchPaymentHistory();
    switch (historyResult) {
      case Success<
            (List<EventPaymentHistory>, List<MembershipPaymentHistory>)>():
        var (eventHistory, membershipHistory) = historyResult.data;
        final eventList =
            eventHistory.map((event) => event.mapToDomain()).toList();
        final memberList = membershipHistory
            .map((membership) => membership.mapToDomain())
            .toList();
        emitNewState(state.copyWith(
            isLoading: false,
            eventHistory: eventList,
            membershipHistory: memberList,
            completeHistory: [...eventList, ...memberList],
            currentSelectedList: [...eventList, ...memberList]));
        break;
      case Failure<
            (List<EventPaymentHistory>, List<MembershipPaymentHistory>)>():
        emitNewState(state.copyWith(
            isLoading: false, error: "Error: ${historyResult.error}"));
    }
  }

  void selectEvent() {
    emitNewState(state.copyWith(
      currentSelectedChip: PaymentHistoryEnums.EVENTS,
      currentSelectedList: state.eventHistory,
    ));
  }

  void selectMembership() {
    emitNewState(state.copyWith(
      currentSelectedChip: PaymentHistoryEnums.MEMBERSHIP,
      currentSelectedList: state.membershipHistory,
    ));
  }

  void selectAll() {
    emitNewState(state.copyWith(
      currentSelectedChip: PaymentHistoryEnums.ALL,
      currentSelectedList: state.completeHistory,
    ));
  }

  void emitNewState(PaymentHistoryState state) {
    emit(state);
  }
}
