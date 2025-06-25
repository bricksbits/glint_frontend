import 'dart:convert';
RazorpayOrderModel razorpayOrderModelFromJson(String str) => RazorpayOrderModel.fromJson(json.decode(str));
String razorpayOrderModelToJson(RazorpayOrderModel data) => json.encode(data.toJson());
class RazorpayOrderModel {
  RazorpayOrderModel({
      this.razorpayKey, 
      this.amount, 
      this.currency, 
      this.name, 
      this.razorpayOrderId,
      this.description, 
      this.timeout, 
      this.prefill,});

  RazorpayOrderModel.fromJson(dynamic json) {
    razorpayKey = json['key'];
    amount = json['amount'];
    currency = json['currency'];
    name = json['name'];
    razorpayOrderId = json['order_id'];
    description = json['description'];
    timeout = json['timeout'];
    prefill = json['prefill'] != null ? Prefill.fromJson(json['prefill']) : null;
  }
  String? razorpayKey;
  int? amount;
  String? currency;
  String? name;
  String? razorpayOrderId;
  String? description;
  int? timeout;
  Prefill? prefill;
RazorpayOrderModel copyWith({  String? key,
  int? amount,
  String? currency,
  String? name,
  String? orderId,
  String? description,
  int? timeout,
  Prefill? prefill,
}) => RazorpayOrderModel(  razorpayKey: key ?? this.razorpayKey,
  amount: amount ?? this.amount,
  currency: currency ?? this.currency,
  name: name ?? this.name,
  razorpayOrderId: orderId ?? this.razorpayOrderId,
  description: description ?? this.description,
  timeout: timeout ?? this.timeout,
  prefill: prefill ?? this.prefill,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = razorpayKey;
    map['amount'] = amount;
    map['currency'] = currency;
    map['name'] = name;
    map['order_id'] = razorpayOrderId;
    map['description'] = description;
    map['timeout'] = timeout;
    if (prefill != null) {
      map['prefill'] = prefill?.toJson();
    }
    return map;
  }

}

Prefill prefillFromJson(String str) => Prefill.fromJson(json.decode(str));
String prefillToJson(Prefill data) => json.encode(data.toJson());
class Prefill {
  Prefill({
      this.contact, 
      this.email,});

  Prefill.fromJson(dynamic json) {
    contact = json['contact'];
    email = json['email'];
  }
  String? contact;
  String? email;
Prefill copyWith({  String? contact,
  String? email,
}) => Prefill(  contact: contact ?? this.contact,
  email: email ?? this.email,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contact'] = contact;
    map['email'] = email;
    return map;
  }

}