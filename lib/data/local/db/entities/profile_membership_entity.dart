import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/remote/model/request/background/update_premium_request_body.dart';

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
  final bool isPremium;

  ProfileMembershipEntity({
    required this.userId,
    required this.superLikes,
    required this.aiMessages,
    required this.rewinds,
    required this.superDm,
    required this.isPremium,
  });
}

extension ProfileMembershipEntityCopy on ProfileMembershipEntity {
  ProfileMembershipEntity copyWith({
    int? superLikes,
    int? aiMessages,
    int? rewinds,
    int? superDm,
    bool? isPremium,
  }) {
    return ProfileMembershipEntity(
      userId: userId,
      superLikes: superLikes ?? this.superLikes,
      aiMessages: aiMessages ?? this.aiMessages,
      rewinds: rewinds ?? this.rewinds,
      superDm: superDm ?? this.superDm,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  UpdatePremiumRequestBody mapToRequestBody() {
    return UpdatePremiumRequestBody(
        aiMessagesRemaining: aiMessages,
        directDmRemaining: superDm,
        rewindsRemaining: rewinds,
        superLikesRemaining: superLikes);
  }
}
