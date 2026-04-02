import 'dart:convert';

GetPaymentHistoryResponse getPaymentHistoryResponseFromJson(String str) =>
    GetPaymentHistoryResponse.fromJson(json.decode(str));

String getPaymentHistoryResponseToJson(GetPaymentHistoryResponse data) =>
    json.encode(data.toJson());

class GetPaymentHistoryResponse {
  GetPaymentHistoryResponse({
    this.eventPaymentHistory,
  });

  GetPaymentHistoryResponse.fromJson(dynamic json) {
    if (json['event_payment_history'] != null) {
      eventPaymentHistory = [];
      json['event_payment_history'].forEach((v) {
        eventPaymentHistory?.add(EventPaymentHistoryItem.fromJson(v));
      });
    }
  }

  List<EventPaymentHistoryItem>? eventPaymentHistory;

  GetPaymentHistoryResponse copyWith({
    List<EventPaymentHistoryItem>? eventPaymentHistory,
  }) =>
      GetPaymentHistoryResponse(
        eventPaymentHistory: eventPaymentHistory ?? this.eventPaymentHistory,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventPaymentHistory != null) {
      map['event_payment_history'] =
          eventPaymentHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EventPaymentHistoryItem {
  EventPaymentHistoryItem({
    this.orderId,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.amount,
    this.orderStatus,
    this.orderDate,
    this.paymentDate,
    this.eventId,
    this.eventName,
  });

  EventPaymentHistoryItem.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    amount = json['amount'];
    orderStatus = json['order_status'];
    orderDate = json['order_date'];
    paymentDate = json['payment_date'];
    eventId = json['event_id'];
    eventName = json['event_name'];
  }

  int? orderId;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  int? amount;
  String? orderStatus;
  String? orderDate;
  String? paymentDate;
  int? eventId;
  String? eventName;

  EventPaymentHistoryItem copyWith({
    int? orderId,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    int? amount,
    String? orderStatus,
    String? orderDate,
    String? paymentDate,
    int? eventId,
    String? eventName,
  }) =>
      EventPaymentHistoryItem(
        orderId: orderId ?? this.orderId,
        razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
        amount: amount ?? this.amount,
        orderStatus: orderStatus ?? this.orderStatus,
        orderDate: orderDate ?? this.orderDate,
        paymentDate: paymentDate ?? this.paymentDate,
        eventId: eventId ?? this.eventId,
        eventName: eventName ?? this.eventName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['razorpay_order_id'] = razorpayOrderId;
    map['razorpay_payment_id'] = razorpayPaymentId;
    map['amount'] = amount;
    map['order_status'] = orderStatus;
    map['order_date'] = orderDate;
    map['payment_date'] = paymentDate;
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    return map;
  }
}
