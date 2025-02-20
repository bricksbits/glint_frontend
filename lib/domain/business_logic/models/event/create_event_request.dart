class CreateEventRequest {
  final String eventName;
  final bool isHotEvent;
  final String eventDescription;
  final double eventLocationLat;
  final double eventLocationLong;
  final String createdTime;
  final String bookTime;
  final String startDateAndTime;
  final String endDateAndTime;
  final int originalPrice;
  final int discountedPrice;
  final int ticketsRemaining;
  final int totalTicket;
  final List<int> categoryList;

  CreateEventRequest(
    this.eventName,
    this.isHotEvent,
    this.eventDescription,
    this.eventLocationLat,
    this.eventLocationLong,
    this.createdTime,
    this.bookTime,
    this.startDateAndTime,
    this.endDateAndTime,
    this.originalPrice,
    this.discountedPrice,
    this.ticketsRemaining,
    this.totalTicket,
    this.categoryList,
  );
}
