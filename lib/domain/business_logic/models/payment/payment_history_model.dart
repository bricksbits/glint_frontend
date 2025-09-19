class PaymentHistoryModel {
  final int? eventId;
  final String historyTitle;
  final String amount;
  final String orderId;
  final String date;
  final String time;
  final PaymentOrderStatus paymentOrderStatus;

  PaymentHistoryModel(this.eventId, this.historyTitle, this.amount,
      this.orderId, this.date, this.time, this.paymentOrderStatus);
}

enum PaymentOrderStatus {
  PAID,
  PENDING,
  CREATED,
}
