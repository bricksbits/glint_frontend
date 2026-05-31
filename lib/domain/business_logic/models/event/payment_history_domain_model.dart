class PaymentHistoryDomainModel {
  final int orderId;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final int amount;
  final String orderStatus;
  final String orderDate;
  final String paymentDate;
  final int eventId;
  final String eventName;

  PaymentHistoryDomainModel({
    required this.orderId,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.amount,
    required this.orderStatus,
    required this.orderDate,
    required this.paymentDate,
    required this.eventId,
    required this.eventName,
  });
}
