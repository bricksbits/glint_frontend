import 'dart:convert';
GetMembershipResponseBody getMembershipResponseBodyFromJson(String str) => GetMembershipResponseBody.fromJson(json.decode(str));
String getMembershipResponseBodyToJson(GetMembershipResponseBody data) => json.encode(data.toJson());
class GetMembershipResponseBody {
  GetMembershipResponseBody({
      this.success, 
      this.message, 
      this.data,});

  GetMembershipResponseBody.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
GetMembershipResponseBody copyWith({  bool? success,
  String? message,
  Data? data,
}) => GetMembershipResponseBody(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.isPremiumUser, 
      this.membershipType, 
      this.validFrom, 
      this.validUntil, 
      this.aiMessagesRemaining, 
      this.directDmRemaining, 
      this.rewindsRemaining, 
      this.superLikesRemaining,});

  Data.fromJson(dynamic json) {
    isPremiumUser = json['is_premium_user'];
    membershipType = json['membership_type'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    aiMessagesRemaining = json['ai_messages_remaining'];
    directDmRemaining = json['direct_dm_remaining'];
    rewindsRemaining = json['rewinds_remaining'];
    superLikesRemaining = json['super_likes_remaining'];
  }
  bool? isPremiumUser;
  String? membershipType;
  String? validFrom;
  String? validUntil;
  int? aiMessagesRemaining;
  int? directDmRemaining;
  int? rewindsRemaining;
  int? superLikesRemaining;
Data copyWith({  bool? isPremiumUser,
  String? membershipType,
  String? validFrom,
  String? validUntil,
  int? aiMessagesRemaining,
  int? directDmRemaining,
  int? rewindsRemaining,
  int? superLikesRemaining,
}) => Data(  isPremiumUser: isPremiumUser ?? this.isPremiumUser,
  membershipType: membershipType ?? this.membershipType,
  validFrom: validFrom ?? this.validFrom,
  validUntil: validUntil ?? this.validUntil,
  aiMessagesRemaining: aiMessagesRemaining ?? this.aiMessagesRemaining,
  directDmRemaining: directDmRemaining ?? this.directDmRemaining,
  rewindsRemaining: rewindsRemaining ?? this.rewindsRemaining,
  superLikesRemaining: superLikesRemaining ?? this.superLikesRemaining,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_premium_user'] = isPremiumUser;
    map['membership_type'] = membershipType;
    map['valid_from'] = validFrom;
    map['valid_until'] = validUntil;
    map['ai_messages_remaining'] = aiMessagesRemaining;
    map['direct_dm_remaining'] = directDmRemaining;
    map['rewinds_remaining'] = rewindsRemaining;
    map['super_likes_remaining'] = superLikesRemaining;
    return map;
  }

}