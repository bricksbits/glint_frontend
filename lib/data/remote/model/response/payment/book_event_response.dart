import 'dart:convert';
BookEventResponse bookEventResponseFromJson(String str) => BookEventResponse.fromJson(json.decode(str));
String bookEventResponseToJson(BookEventResponse data) => json.encode(data.toJson());
class BookEventResponse {
  BookEventResponse({
      this.success,});

  BookEventResponse.fromJson(dynamic json) {
    success = json['success'] != null ? Success.fromJson(json['success']) : null;
  }
  Success? success;
BookEventResponse copyWith({  Success? success,
}) => BookEventResponse(  success: success ?? this.success,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (success != null) {
      map['success'] = success?.toJson();
    }
    return map;
  }

}

Success successFromJson(String str) => Success.fromJson(json.decode(str));
String successToJson(Success data) => json.encode(data.toJson());
class Success {
  Success({
      this.orderId, 
      this.razorpayOrderId, 
      this.razorpayKey,});

  Success.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayKey = json['razorpay_key'];
  }
  int? orderId;
  String? razorpayOrderId;
  String? razorpayKey;
Success copyWith({  int? orderId,
  String? razorpayOrderId,
  String? razorpayKey,
}) => Success(  orderId: orderId ?? this.orderId,
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