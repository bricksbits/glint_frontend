/// Will be used for the Recent Matches
/// Show Image, Icon,
/// Should have Chat Channel, User Id, Match Id
class RecentMatchesModel {
  final String matchUserId;
  final String matchUserName;
  final String matchUserImageUrl;
  final String matchId;
  final String chatChannelId;
  final bool matchedAtEvent;
  final String? eventId;
  final String? eventName;
  final String? eventStartTime;

  RecentMatchesModel({
    required this.matchUserId,
    required this.matchUserName,
    required this.matchUserImageUrl,
    required this.matchId,
    required this.chatChannelId,
    required this.matchedAtEvent,
    required this.eventId,
    required this.eventName,
    required this.eventStartTime,
  });
}
