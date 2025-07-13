import 'dart:convert';
UserActionRequestModel userActionRequestModelFromJson(String str) => UserActionRequestModel.fromJson(json.decode(str));
String userActionRequestModelToJson(UserActionRequestModel data) => json.encode(data.toJson());
class UserActionRequestModel {
  UserActionRequestModel({
      this.actions,});

  UserActionRequestModel.fromJson(dynamic json) {
    if (json['actions'] != null) {
      actions = [];
      json['actions'].forEach((v) {
        actions?.add(Actions.fromJson(v));
      });
    }
  }
  List<Actions>? actions;
UserActionRequestModel copyWith({  List<Actions>? actions,
}) => UserActionRequestModel(  actions: actions ?? this.actions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (actions != null) {
      map['actions'] = actions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Actions actionsFromJson(String str) => Actions.fromJson(json.decode(str));
String actionsToJson(Actions data) => json.encode(data.toJson());
class Actions {
  Actions({
      this.onUserId, 
      this.action,});

  Actions.fromJson(dynamic json) {
    onUserId = json['on_user_id'];
    action = json['action'];
  }
  int? onUserId;
  String? action;
Actions copyWith({  int? onUserId,
  String? action,
}) => Actions(  onUserId: onUserId ?? this.onUserId,
  action: action ?? this.action,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['on_user_id'] = onUserId;
    map['action'] = action;
    return map;
  }

}