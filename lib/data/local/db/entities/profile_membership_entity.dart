import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

@Entity(
  tableName: 'memberships',
  foreignKeys: [
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['userId'],
      entity: ProfileEntity,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class ProfileMembershipEntity {
  @primaryKey
  final String userId;
  final int superLikes;
  final int aiMessages;
  final int rewinds;
  final int superDm;

  ProfileMembershipEntity({
    required this.userId,
    required this.superLikes,
    required this.aiMessages,
    required this.rewinds,
    required this.superDm,
  });
}
