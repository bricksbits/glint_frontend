import 'dart:convert';
SuperDmOnRequestBody superDmOnRequestBodyFromJson(String str) => SuperDmOnRequestBody.fromJson(json.decode(str));
String superDmOnRequestBodyToJson(SuperDmOnRequestBody data) => json.encode(data.toJson());
class SuperDmOnRequestBody {
  SuperDmOnRequestBody({
      this.onUserId,});

  SuperDmOnRequestBody.fromJson(dynamic json) {
    onUserId = json['on_user_id'];
  }
  int? onUserId;
SuperDmOnRequestBody copyWith({  int? onUserId,
}) => SuperDmOnRequestBody(  onUserId: onUserId ?? this.onUserId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['on_user_id'] = onUserId;
    return map;
  }

}