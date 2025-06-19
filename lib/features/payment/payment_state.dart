part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initiate({
    @Default("") final String? orderId,
    @Default("") final String? key,
    @Default("") final String? amount,
    @Default("") final String? razorpayKey,
    @Default("") final String? name,
    @Default("") final String? description,
  }) = _Initiate;
}
