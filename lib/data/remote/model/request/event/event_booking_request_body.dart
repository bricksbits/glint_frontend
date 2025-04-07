class EventBookingRequestBody {
  final int eventId;
  final int matchId;

  EventBookingRequestBody({required this.eventId, required this.matchId});

  factory EventBookingRequestBody.fromJson(Map<String, dynamic> json) {
    return EventBookingRequestBody(
      eventId: json['event_id'],
      matchId: json['match_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'match_id': matchId,
    };
  }
}
