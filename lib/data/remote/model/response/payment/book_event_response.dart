import 'dart:convert';
BookEventResponse bookEventResponseFromJson(String str) => BookEventResponse.fromJson(json.decode(str));
String bookEventResponseToJson(BookEventResponse data) => json.encode(data.toJson());
class BookEventResponse {
  BookEventResponse({
      this.success, 
      this.message, 
      this.data,});

  BookEventResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
BookEventResponse copyWith({  bool? success,
  String? message,
  Data? data,
}) => BookEventResponse(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.orderId, 
      this.razorpayOrderId, 
      this.razorpayKey,});

  Data.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayKey = json['razorpay_key'];
  }
  int? orderId;
  String? razorpayOrderId;
  String? razorpayKey;
Data copyWith({  int? orderId,
  String? razorpayOrderId,
  String? razorpayKey,
}) => Data(  orderId: orderId ?? this.orderId,
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