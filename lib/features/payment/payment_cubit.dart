import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart'
    as bookEventResponse;
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/features/payment/model/razorpay_order_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'payment_state.dart';

part 'payment_cubit.freezed.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo = getIt.get<PaymentRepo>();

  PaymentCubit() : super(const PaymentState.initiate());

  int? orderIdReceived = 0;
  String? razorPayKey = "";
  String? razorPayOrderId = "";

  void collectTicketInformation() {}

  void collectMembershipInformation() {}

  Future<void> bookTheEvent(
    String eventId,
    String matchId,
  ) async {
    final eventResponse = await paymentRepo.bookEvent(eventId, matchId);
    switch (eventResponse) {
      case Success<bookEventResponse.BookEventResponse>():
        final orderResponse = eventResponse.data;
        orderIdReceived = orderResponse.success?.orderId;
        razorPayKey = orderResponse.success?.razorpayKey;
        razorPayOrderId = orderResponse.success?.razorpayOrderId;
      case Failure<bookEventResponse.BookEventResponse>():
        print("BookEvent : Failed ${eventResponse.error}");
    }
  }

  Future<void> getTheMembership() async {}

  RazorpayOrderModel generateTheOrderId(
    String razorpayKey,
    String amount,
  ) {
    print("Order Generated with Id: $razorPayOrderId and Key: $razorPayKey");
    final amountParsed = int.parse("3200");
    return RazorpayOrderModel(
      key: razorPayKey,
      amount: amountParsed,
      orderId: razorPayOrderId,
      name: state.name,
      description: state.description,
    );
  }

  Future<void> verifyThePayment(
    String orderId,
    String paymentId,
  ) async {
    final verifyResponse = await paymentRepo.verifyPayment(orderId, paymentId);
    switch (verifyResponse) {
      case Success<void>():
        print("VerifyPayment : Payment got verified");
      case Failure<void>():
        print("VerifyPayment : Payment failed : ${verifyResponse.error}");
    }
  }
}
