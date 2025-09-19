part of 'payment_history_cubit.dart';

@freezed
class PaymentHistoryState with _$PaymentHistoryState {
  const factory PaymentHistoryState.initial({
    @Default([]) List<PaymentHistoryModel> completeHistory,
    @Default([]) List<PaymentHistoryModel> eventHistory,
    @Default([]) List<PaymentHistoryModel> membershipHistory,
    @Default([]) List<PaymentHistoryModel> currentSelectedList,
    @Default(false) bool isLoading,
    @Default("") String error,
    @Default(PaymentHistoryEnums.ALL) PaymentHistoryEnums currentSelectedChip,
  }) = _Initial;
}

enum PaymentHistoryEnums {
  ALL,
  EVENTS,
  MEMBERSHIP,
}
