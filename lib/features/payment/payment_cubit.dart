import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart'
    as bookEventResponse;
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/features/payment/model/razorpay_order_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

part 'payment_state.dart';

part 'payment_cubit.freezed.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo = getIt.get<PaymentRepo>();

  PaymentCubit() : super(const PaymentState.initiate());

  void collectPaymentRequest(PaymentArgumentModel? paymentRequest){

  }

  Future<void> bookTheEvent(
    String eventId,
    String matchId,
  ) async {
    print("Booking started");
    final eventResponse = await paymentRepo.bookEvent(eventId, matchId);
    switch (eventResponse) {
      case Success<bookEventResponse.BookEventResponse>():
        final orderResponse = eventResponse.data;
        final orderIdReceived = orderResponse.success?.orderId;
        final razorPayKey = orderResponse.success?.razorpayKey;
        final razorPayOrderId = orderResponse.success?.razorpayOrderId;
        if (razorPayOrderId != null && razorPayKey != null) {
          generateTheOrderId(razorPayKey, razorPayOrderId);
        }
      case Failure<bookEventResponse.BookEventResponse>():
        print("BookEvent : Failed ${eventResponse.error}");
    }
  }

  Future<void> getTheMembership() async {}

  void updateStateForNoReason() {
    emit(state.copyWith(
      name: "NEW NAME",
      description: "NEW DESC"
    ));
  }

  void generateTheOrderId(
    String razorpayKey,
    String razorpayOrderId,
  ) {
    print("Order Generated with Id: $razorpayOrderId and Key: $razorpayKey");
    final amountParsed = int.parse("3200");
    final orderObject = RazorpayOrderModel(
      key: razorpayKey,
      amount: amountParsed,
      orderId: razorpayOrderId,
      name: state.name,
      description: state.description,
    );
    emit(state.copyWith(razorpayModel: orderObject));
  }

  Future<void> verifyThePayment(
    String orderId,
    String paymentId,
  ) async {
    print("Verification Started");
    final verifyResponse = await paymentRepo.verifyPayment(orderId, paymentId);
    switch (verifyResponse) {
      case Success<void>():
        print("VerifyPayment : Payment got verified");
      case Failure<void>():
        print("VerifyPayment : Payment failed : ${verifyResponse.error}");
    }
  }
}
