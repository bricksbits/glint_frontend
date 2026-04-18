class PaginationParams {
  final int offset;

  const PaginationParams({this.offset = 0});
}

class EventPaginationParams {
  final int eventId;
  final int offset;

  const EventPaginationParams({
    required this.eventId,
    this.offset = 0,
  });
}
