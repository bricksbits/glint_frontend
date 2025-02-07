class BookEventTicketRequest {
  final String eventId;
  final String totalTickets;
  final List<String> userIdList;

  BookEventTicketRequest(
    this.eventId,
    this.totalTickets,
    this.userIdList,
  );
}
