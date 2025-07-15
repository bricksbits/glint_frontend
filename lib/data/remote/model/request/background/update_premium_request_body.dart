import 'dart:convert';
UpdatePremiumRequestBody updatePremiumRequestBodyFromJson(String str) => UpdatePremiumRequestBody.fromJson(json.decode(str));
String updatePremiumRequestBodyToJson(UpdatePremiumRequestBody data) => json.encode(data.toJson());
class UpdatePremiumRequestBody {
  UpdatePremiumRequestBody({
      this.aiMessagesRemaining, 
      this.directDmRemaining, 
      this.rewindsRemaining, 
      this.superLikesRemaining,});

  UpdatePremiumRequestBody.fromJson(dynamic json) {
    aiMessagesRemaining = json['ai_messages_remaining'];
    directDmRemaining = json['direct_dm_remaining'];
    rewindsRemaining = json['rewinds_remaining'];
    superLikesRemaining = json['super_likes_remaining'];
  }
  int? aiMessagesRemaining;
  int? directDmRemaining;
  int? rewindsRemaining;
  int? superLikesRemaining;
UpdatePremiumRequestBody copyWith({  int? aiMessagesRemaining,
  int? directDmRemaining,
  int? rewindsRemaining,
  int? superLikesRemaining,
}) => UpdatePremiumRequestBody(  aiMessagesRemaining: aiMessagesRemaining ?? this.aiMessagesRemaining,
  directDmRemaining: directDmRemaining ?? this.directDmRemaining,
  rewindsRemaining: rewindsRemaining ?? this.rewindsRemaining,
  superLikesRemaining: superLikesRemaining ?? this.superLikesRemaining,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ai_messages_remaining'] = aiMessagesRemaining;
    map['direct_dm_remaining'] = directDmRemaining;
    map['rewinds_remaining'] = rewindsRemaining;
    map['super_likes_remaining'] = superLikesRemaining;
    return map;
  }

}