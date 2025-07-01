import 'dart:convert';
BuyMembershipRequest buyMembershipRequestFromJson(String str) => BuyMembershipRequest.fromJson(json.decode(str));
String buyMembershipRequestToJson(BuyMembershipRequest data) => json.encode(data.toJson());
class BuyMembershipRequest {
  BuyMembershipRequest({
      this.price, 
      this.numberOfDays, 
      this.membershipType,});

  BuyMembershipRequest.fromJson(dynamic json) {
    price = json['price'];
    numberOfDays = json['number_of_days'];
    membershipType = json['membership_type'];
  }
  int? price;
  int? numberOfDays;
  String? membershipType;
BuyMembershipRequest copyWith({  int? price,
  int? numberOfDays,
  String? membershipType,
}) => BuyMembershipRequest(  price: price ?? this.price,
  numberOfDays: numberOfDays ?? this.numberOfDays,
  membershipType: membershipType ?? this.membershipType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['number_of_days'] = numberOfDays;
    map['membership_type'] = membershipType;
    return map;
  }

}