import 'dart:convert';
VerifyPaymentRequestBody verifyPaymentRequestBodyFromJson(String str) => VerifyPaymentRequestBody.fromJson(json.decode(str));
String verifyPaymentRequestBodyToJson(VerifyPaymentRequestBody data) => json.encode(data.toJson());
class VerifyPaymentRequestBody {
  VerifyPaymentRequestBody({
      this.orderId, 
      this.razorpayPaymentId, 
      this.razorpaySignature, 
      this.razorpayOrderId,});

  VerifyPaymentRequestBody.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpaySignature = json['razorpay_signature'];
    razorpayOrderId = json['razorpay_order_id'];
  }
  int? orderId;
  String? razorpayPaymentId;
  String? razorpaySignature;
  String? razorpayOrderId;
VerifyPaymentRequestBody copyWith({  int? orderId,
  String? razorpayPaymentId,
  String? razorpaySignature,
  String? razorpayOrderId,
}) => VerifyPaymentRequestBody(  orderId: orderId ?? this.orderId,
  razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
  razorpaySignature: razorpaySignature ?? this.razorpaySignature,
  razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['razorpay_payment_id'] = razorpayPaymentId;
    map['razorpay_signature'] = razorpaySignature;
    map['razorpay_order_id'] = razorpayOrderId;
    return map;
  }

}