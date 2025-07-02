import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

@Entity(
  tableName: 'user_event_likes',
  primaryKeys: ['userId', 'eventId'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['userId'],
      entity: ProfileEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class UserEventLikeEntity {
  final String userId;
  final String eventId;

  UserEventLikeEntity({
    required this.userId,
    required this.eventId,
  });
}
