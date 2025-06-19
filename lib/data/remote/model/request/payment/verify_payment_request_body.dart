import 'dart:convert';
VerifyPaymentRequestBody verifyPaymentRequestBodyFromJson(String str) => VerifyPaymentRequestBody.fromJson(json.decode(str));
String verifyPaymentRequestBodyToJson(VerifyPaymentRequestBody data) => json.encode(data.toJson());
class VerifyPaymentRequestBody {
  VerifyPaymentRequestBody({
      this.orderId, 
      this.razorpayPaymentId,});

  VerifyPaymentRequestBody.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
  }
  int? orderId;
  String? razorpayPaymentId;
VerifyPaymentRequestBody copyWith({  int? orderId,
  String? razorpayPaymentId,
}) => VerifyPaymentRequestBody(  orderId: orderId ?? this.orderId,
  razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['razorpay_payment_id'] = razorpayPaymentId;
    return map;
  }

}