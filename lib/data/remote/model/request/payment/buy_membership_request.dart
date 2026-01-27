import 'dart:convert';

BuyMembershipRequest buyMembershipRequestFromJson(String str) =>
    BuyMembershipRequest.fromJson(json.decode(str));

String buyMembershipRequestToJson(BuyMembershipRequest data) =>
    json.encode(data.toJson());

class BuyMembershipRequest {
  BuyMembershipRequest({
    this.membershipType,
  });

  BuyMembershipRequest.fromJson(dynamic json) {
    membershipType = json['membership_type'];
  }

  String? membershipType;

  BuyMembershipRequest copyWith({
    int? price,
    int? numberOfDays,
    String? membershipType,
  }) =>
      BuyMembershipRequest(
        membershipType: membershipType ?? this.membershipType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['membership_type'] = membershipType;
    return map;
  }
}
