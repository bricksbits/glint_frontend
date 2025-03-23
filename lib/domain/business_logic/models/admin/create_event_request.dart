class CreateEventRequestDomainModel {
  String eventName;
  bool isHotEvent;
  String eventDescription;
  double eventLocationLat;
  double eventLocationLong;
  String createdTime;
  String bookTime;
  String startDateAndTime;
  String endDateAndTime;
  int originalPrice;
  int discountedPrice;
  int ticketsRemaining;
  int totalTicket;
  List<int> categoryList;

  CreateEventRequestDomainModel({
    required this.eventName,
    required this.isHotEvent,
    required this.eventDescription,
    required this.eventLocationLat,
    required this.eventLocationLong,
    required this.createdTime,
    required this.bookTime,
    required this.startDateAndTime,
    required this.endDateAndTime,
    required this.originalPrice,
    required this.discountedPrice,
    required this.ticketsRemaining,
    required this.totalTicket,
    required this.categoryList,
  });
}
