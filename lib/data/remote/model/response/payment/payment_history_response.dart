import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/payment/payment_history_model.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

PaymentHistoryResponse paymentHistoryResponseFromJson(String str) =>
    PaymentHistoryResponse.fromJson(json.decode(str));

String paymentHistoryResponseToJson(PaymentHistoryResponse data) =>
    json.encode(data.toJson());

class PaymentHistoryResponse {
  PaymentHistoryResponse({
    this.paymentHistory,
  });

  PaymentHistoryResponse.fromJson(dynamic json) {
    paymentHistory = json['payment_history'] != null
        ? PaymentHistory.fromJson(json['payment_history'])
        : null;
  }

  PaymentHistory? paymentHistory;

  PaymentHistoryResponse copyWith({
    PaymentHistory? paymentHistory,
  }) =>
      PaymentHistoryResponse(
        paymentHistory: paymentHistory ?? this.paymentHistory,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentHistory != null) {
      map['payment_history'] = paymentHistory?.toJson();
    }
    return map;
  }
}

PaymentHistory paymentHistoryFromJson(String str) =>
    PaymentHistory.fromJson(json.decode(str));

String paymentHistoryToJson(PaymentHistory data) => json.encode(data.toJson());

class PaymentHistory {
  PaymentHistory({
    this.eventPaymentHistory,
    this.membershipPaymentHistory,
  });

  PaymentHistory.fromJson(dynamic json) {
    if (json['event_payment_history'] != null) {
      eventPaymentHistory = [];
      json['event_payment_history'].forEach((v) {
        eventPaymentHistory?.add(EventPaymentHistory.fromJson(v));
      });
    }
    if (json['membership_payment_history'] != null) {
      membershipPaymentHistory = [];
      json['membership_payment_history'].forEach((v) {
        membershipPaymentHistory?.add(MembershipPaymentHistory.fromJson(v));
      });
    }
  }

  List<EventPaymentHistory>? eventPaymentHistory;
  List<MembershipPaymentHistory>? membershipPaymentHistory;

  PaymentHistory copyWith({
    List<EventPaymentHistory>? eventPaymentHistory,
    List<MembershipPaymentHistory>? membershipPaymentHistory,
  }) =>
      PaymentHistory(
        eventPaymentHistory: eventPaymentHistory ?? this.eventPaymentHistory,
        membershipPaymentHistory:
            membershipPaymentHistory ?? this.membershipPaymentHistory,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventPaymentHistory != null) {
      map['event_payment_history'] =
          eventPaymentHistory?.map((v) => v.toJson()).toList();
    }
    if (membershipPaymentHistory != null) {
      map['membership_payment_history'] =
          membershipPaymentHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

MembershipPaymentHistory membershipPaymentHistoryFromJson(String str) =>
    MembershipPaymentHistory.fromJson(json.decode(str));

String membershipPaymentHistoryToJson(MembershipPaymentHistory data) =>
    json.encode(data.toJson());

class MembershipPaymentHistory {
  MembershipPaymentHistory({
    this.orderId,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.amount,
    this.orderStatus,
    this.orderDate,
    this.paymentDate,
    this.membershipType,
  });

  MembershipPaymentHistory.fromJson(dynamic json) {
    orderId = json['order_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    amount = json['amount'];
    orderStatus = json['order_status'];
    orderDate = json['order_date'];
    paymentDate = json['payment_date'];
    membershipType = json['membership_type'];
  }

  int? orderId;
  String? razorpayOrderId;
  dynamic razorpayPaymentId;
  int? amount;
  String? orderStatus;
  String? orderDate;
  String? paymentDate;
  String? membershipType;

  MembershipPaymentHistory copyWith({
    int? orderId,
    String? razorpayOrderId,
    dynamic razorpayPaymentId,
    int? amount,
    String? orderStatus,
    String? orderDate,
    String? paymentDate,
    String? membershipType,
  }) =>
      MembershipPaymentHistory(
        orderId: orderId ?? this.orderId,
        razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
        amount: amount ?? this.amount,
        orderStatus: orderStatus ?? this.orderStatus,
        orderDate: orderDate ?? this.orderDate,
        paymentDate: paymentDate ?? this.paymentDate,
        membershipType: membershipType ?? this.membershipType,
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
    map['membership_type'] = membershipType;
    return map;
  }
}

EventPaymentHistory eventPaymentHistoryFromJson(String str) =>
    EventPaymentHistory.fromJson(json.decode(str));

String eventPaymentHistoryToJson(EventPaymentHistory data) =>
    json.encode(data.toJson());

class EventPaymentHistory {
  EventPaymentHistory({
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

  EventPaymentHistory.fromJson(dynamic json) {
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

  EventPaymentHistory copyWith({
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
      EventPaymentHistory(
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

extension EventPaymentHistoryMapper on EventPaymentHistory {
  PaymentHistoryModel mapToDomain() {
    final parseDate = paymentDate != null
        ? dateFromStandardResponse(paymentDate!)
        : DateTime.now();
    final orderStatusChecked = orderStatus == "paid"
        ? PaymentOrderStatus.PAID
        : orderStatus == "created"
            ? PaymentOrderStatus.CREATED
            : PaymentOrderStatus.PENDING;
    return PaymentHistoryModel(
      eventId,
      eventName ?? "Event Name",
      amount.toString(),
      orderId.toString(),
      parseDate.toFormattedDate(),
      parseDate.toFormattedTime(),
      orderStatusChecked,
    );
  }
}

extension MembershipPaymentHistoryMapper on MembershipPaymentHistory {
  PaymentHistoryModel mapToDomain() {
    final parseDate = paymentDate != null
        ? dateFromStandardResponse(paymentDate!)
        : DateTime.now();
    final orderStatusChecked = orderStatus == "paid"
        ? PaymentOrderStatus.PAID
        : orderStatus == "created"
            ? PaymentOrderStatus.CREATED
            : PaymentOrderStatus.PENDING;
    final eventName = membershipType != null
        ? membershipType!.contains("gold")
            ? "Gold Membership"
            : membershipType!.contains("platinum")
                ? "Platinum Membership"
                : "Premium"
        : "Membership";
    return PaymentHistoryModel(
      null,
      eventName,
      amount.toString(),
      orderId.toString(),
      parseDate.toFormattedDate(),
      parseDate.toFormattedTime(),
      orderStatusChecked,
    );
  }
}
