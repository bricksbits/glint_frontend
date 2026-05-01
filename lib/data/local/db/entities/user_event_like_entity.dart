import 'package:floor/floor.dart';

@Entity(
  tableName: 'user_event_likes',
  primaryKeys: ['userId', 'eventId'],
)
class UserEventLikeEntity {
  final String userId;
  final String eventId;

  UserEventLikeEntity({
    required this.userId,
    required this.eventId,
  });
}
