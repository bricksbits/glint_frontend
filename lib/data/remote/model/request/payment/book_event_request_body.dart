import 'dart:convert';
BookEventRequestBody bookEventRequestBodyFromJson(String str) => BookEventRequestBody.fromJson(json.decode(str));
String bookEventRequestBodyToJson(BookEventRequestBody data) => json.encode(data.toJson());
class BookEventRequestBody {
  BookEventRequestBody({
      this.eventId, 
      this.matchId,});

  BookEventRequestBody.fromJson(dynamic json) {
    eventId = json['event_id'];
    matchId = json['match_id'];
  }
  int? eventId;
  int? matchId;
BookEventRequestBody copyWith({  int? eventId,
  int? matchId,
}) => BookEventRequestBody(  eventId: eventId ?? this.eventId,
  matchId: matchId ?? this.matchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['match_id'] = matchId;
    return map;
  }

}