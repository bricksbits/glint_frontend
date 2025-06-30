import 'dart:convert';
BuyMembershipResponse buyMembershipResponseFromJson(String str) => BuyMembershipResponse.fromJson(json.decode(str));
String buyMembershipResponseToJson(BuyMembershipResponse data) => json.encode(data.toJson());
class BuyMembershipResponse {
  BuyMembershipResponse({
      this.orderId, 
      this.razorpayOrderId, 
      this.razorpayKey,});

  BuyMembershipResponse.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayKey = json['razorpay_key'];
  }
  int? orderId;
  String? razorpayOrderId;
  String? razorpayKey;
BuyMembershipResponse copyWith({  int? orderId,
  String? razorpayOrderId,
  String? razorpayKey,
}) => BuyMembershipResponse(  orderId: orderId ?? this.orderId,
  razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
  razorpayKey: razorpayKey ?? this.razorpayKey,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['razorpay_order_id'] = razorpayOrderId;
    map['razorpay_key'] = razorpayKey;
    return map;
  }

}