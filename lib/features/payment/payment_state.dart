part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initiate({
    @Default(null) final int? orderId,
    @Default("") final String? totalAmount,
    @Default("") final String? name,
    @Default("") final String? description,
    @Default(null) final RazorpayOrderModel? razorpayModel,
    @Default(null) final PaymentArgumentModel? paymentModel,
    @Default(true) final bool loading,
    @Default(false) final bool isMembershipRequest,
    @Default("") final String? error,
  }) = _Initiate;
}
