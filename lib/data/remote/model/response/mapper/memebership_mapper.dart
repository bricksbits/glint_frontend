import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/remote/model/response/membership/get_membership_response_body.dart';

extension MembershipMapper on GetMembershipResponseBody {
  ProfileMembershipEntity mapToEntity(String userId) {
    return ProfileMembershipEntity(
      userId: userId,
      superLikes: data?.superLikesRemaining ?? 0,
      aiMessages: data?.aiMessagesRemaining ?? 0,
      rewinds: data?.rewindsRemaining ?? 0,
      superDm: data?.directDmRemaining ?? 0,
      isPremium: data?.isPremiumUser ?? false,
    );
  }
}
