import 'dart:convert';

import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';

GetMembershipResponseBody getMembershipResponseBodyFromJson(String str) =>
    GetMembershipResponseBody.fromJson(json.decode(str));

String getMembershipResponseBodyToJson(GetMembershipResponseBody data) =>
    json.encode(data.toJson());

class GetMembershipResponseBody {
  GetMembershipResponseBody({
    this.response,});

  GetMembershipResponseBody.fromJson(dynamic json) {
    response =
    json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Response? response;

  GetMembershipResponseBody copyWith({ Response? response,
  }) =>
      GetMembershipResponseBody(response: response ?? this.response,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.isPremiumUser,
    this.aiMessagesRemaining,
    this.directDmRemaining,
    this.rewindsRemaining,
    this.superLikesRemaining,});

  Response.fromJson(dynamic json) {
    isPremiumUser = json['is_premium_user'];
    aiMessagesRemaining = json['ai_messages_remaining'];
    directDmRemaining = json['direct_dm_remaining'];
    rewindsRemaining = json['rewinds_remaining'];
    superLikesRemaining = json['super_likes_remaining'];
  }

  bool? isPremiumUser;
  int? aiMessagesRemaining;
  int? directDmRemaining;
  int? rewindsRemaining;
  int? superLikesRemaining;

  Response copyWith({ bool? isPremiumUser,
    int? aiMessagesRemaining,
    int? directDmRemaining,
    int? rewindsRemaining,
    int? superLikesRemaining,
  }) =>
      Response(
        isPremiumUser: isPremiumUser ?? this.isPremiumUser,
        aiMessagesRemaining: aiMessagesRemaining ?? this.aiMessagesRemaining,
        directDmRemaining: directDmRemaining ?? this.directDmRemaining,
        rewindsRemaining: rewindsRemaining ?? this.rewindsRemaining,
        superLikesRemaining: superLikesRemaining ?? this.superLikesRemaining,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_premium_user'] = isPremiumUser;
    map['ai_messages_remaining'] = aiMessagesRemaining;
    map['direct_dm_remaining'] = directDmRemaining;
    map['rewinds_remaining'] = rewindsRemaining;
    map['super_likes_remaining'] = superLikesRemaining;
    return map;
  }
}

extension MembershipMapper on GetMembershipResponseBody {
  ProfileMembershipEntity mapToEntity(String userId) {
    return ProfileMembershipEntity(
      userId: userId,
      superLikes: response?.superLikesRemaining ?? 0,
      aiMessages: response?.aiMessagesRemaining ?? 0,
      rewinds: response?.rewindsRemaining ?? 0,
      superDm: response?.directDmRemaining ?? 0,
    );
  }
}
