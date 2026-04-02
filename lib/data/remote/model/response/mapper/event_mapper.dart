import 'package:glint_frontend/data/remote/model/response/event/get_payment_history_response.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_ticket_hisotry_response.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/payment_history_domain_model.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

extension GetPaymentHistoryResponseMapper on GetPaymentHistoryResponse {
  List<PaymentHistoryDomainModel> mapToDomainModel() {
    return eventPaymentHistory?.map((item) {
          return PaymentHistoryDomainModel(
            orderId: item.orderId ?? 0,
            razorpayOrderId: item.razorpayOrderId ?? "",
            razorpayPaymentId: item.razorpayPaymentId ?? "",
            amount: item.amount ?? 0,
            orderStatus: item.orderStatus ?? "",
            orderDate: item.orderDate ?? "",
            paymentDate: item.paymentDate ?? "",
            eventId: item.eventId ?? 0,
            eventName: item.eventName ?? "",
          );
        }).toList() ??
        [];
  }
}

extension GetTicketHistoryResponseMapper on GetTicketHisotryResponse {
  List<EventTicketHistoryDomainModel> mapToDomainModel() {
    return data?.tickets?.map((ticket) {
          final ticketDate =
              ticket.eventStartTime ?? DateTime.now().toIso8601String();
          final eventDate =
              dateFromStandardResponse(ticketDate).toFormattedDate();
          final eventDateTime =
              dateFromStandardResponse(ticketDate).toFormattedTime();
          return EventTicketHistoryDomainModel(
            eventId: ticket.eventId.toString(),
            eventName: ticket.eventName ?? "",
            eventCoverImageUrl: ticket.eventPictureUrl?.presignedUrl ?? "",
            eventdate: eventDate,
            eventTime: eventDateTime,
            eventLocation: ticket.eventLocationName ?? "",
            eventOldPrice: "",
            eventCurrentPrice: ticket.ticketPrice.toString(),
            daysLeft: "",
            location: {
              "lat": ticket.locationLatitude.toString(),
              "long": ticket.locationLongitude.toString()
            },
            currentUser: UserTicketHolderModel(
              userId: ticket.user1Id.toString(),
              username: ticket.user1Username.toString(),
              imageUrl: ticket.user1ProfilePictureUrl?.presignedUrl ?? "",
            ),
            matchedUser: UserTicketHolderModel(
              userId: ticket.user2Id.toString(),
              username: ticket.user2Username.toString(),
              imageUrl: ticket.user2ProfilePictureUrl?.presignedUrl ?? "",
            ),
          );
        }).toList() ??
        [];
  }
}
