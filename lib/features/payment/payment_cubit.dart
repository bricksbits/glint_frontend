import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart'
    as bookEventResponse;
import 'package:glint_frontend/data/remote/model/response/payment/buy_membership_response.dart';
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

  void collectPaymentRequest(PaymentArgumentModel? paymentRequest) {
    emit(
      state.copyWith(
          paymentModel: paymentRequest,
          loading: false,
          isMembershipRequest: paymentRequest?.membershipType != null &&
              paymentRequest?.eventId == null),
    );
  }

  Future<void> bookTheEvent() async {
    final eventId = state.paymentModel?.eventId;
    final matchId = state.paymentModel?.matchId;
    final amount = state.totalAmount;
    if (eventId != null && matchId != null) {
      final eventResponse = await paymentRepo.bookEvent(eventId, matchId);
      switch (eventResponse) {
        case Success<bookEventResponse.BookEventResponse>():
          final orderResponse = eventResponse.data;
          final orderIdReceived = orderResponse.success?.orderId;
          if (orderIdReceived != null) {
            emitNewState(state.copyWith(
              orderId: orderIdReceived,
            ));
          }
          final razorPayKey = orderResponse.success?.razorpayKey;
          final razorPayOrderId = orderResponse.success?.razorpayOrderId;
          if (razorPayOrderId != null && razorPayKey != null && amount != null) {
            generateTheOrderId(razorPayKey, razorPayOrderId, "1200");
          }
        case Failure<bookEventResponse.BookEventResponse>():
          print("BookEvent : Failed ${eventResponse.error}");
      }
    } else {
      emit(state.copyWith(
          error: "Can't initiate the event payment, try again please,"));
    }
  }

  Future<void> getTheMembership() async {
    final membershipType = state.paymentModel?.membershipType;
    final membershipAmount = state.paymentModel?.amountOfSelectedMembership;
    final membershipTime = state.paymentModel?.timePeriod;
    if (membershipTime != null &&
        membershipAmount != null &&
        membershipType != null) {
      final getMembershipResponse = await paymentRepo.buyMembership(
        membershipType,
        membershipAmount,
        membershipTime,
      );

      switch (getMembershipResponse) {
        case Success<BuyMembershipResponse>():
          final orderResponse = getMembershipResponse.data;
          final orderIdReceived = orderResponse.orderId;
          final razorPayKey = orderResponse.razorpayKey;
          final razorPayOrderId = orderResponse.razorpayOrderId;
          if (orderIdReceived != null) {
            emitNewState(state.copyWith(orderId: orderIdReceived));
          }
          if (razorPayOrderId != null && razorPayKey != null) {
            generateTheOrderId(
              razorPayKey,
              razorPayOrderId,
              membershipAmount,
            );
          }
        case Failure<BuyMembershipResponse>():
          emit(state.copyWith(
              error: "Can't verify the membership request, try again please,"));
      }
    } else {
      emit(state.copyWith(
          error: "Can't proceed with Membership, please try again"));
    }
  }

  void generateTheOrderId(
    String razorpayKey,
    String razorpayOrderId,
    String amount,
  ) {
    print("Order Generated with Id: $razorpayOrderId and Key: $razorpayKey");
    final orderObject = RazorpayOrderModel(
      razorpayKey: razorpayKey,
      amount: int.parse(amount),
      razorpayOrderId: razorpayOrderId,
      name: state.name,
      description: state.description,
    );
    emit(state.copyWith(razorpayModel: orderObject));
  }

  Future<void> verifyThePayment(
    String razorpayPaymentId,
  ) async {
    final myOrderId = state.orderId;
    print(
        "Verification Started with Order ID : $myOrderId and $razorpayPaymentId");
    if (myOrderId != null) {
      final verifyResponse =
          await paymentRepo.verifyPayment(myOrderId, razorpayPaymentId);
      switch (verifyResponse) {
        case Success<void>():
          print("VerifyPayment : Payment got verified");
        case Failure<void>():
          print("VerifyPayment : Payment failed : ${verifyResponse.error}");
      }
    }
  }

  void emitNewState(PaymentState newState) {
    emit(newState);
  }
}
