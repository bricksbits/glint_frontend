import 'dart:convert';
UserActionResponse userActionResponseFromJson(String str) => UserActionResponse.fromJson(json.decode(str));
String userActionResponseToJson(UserActionResponse data) => json.encode(data.toJson());
class UserActionResponse {
  UserActionResponse({
      this.message,});

  UserActionResponse.fromJson(dynamic json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  Message? message;
UserActionResponse copyWith({  Message? message,
}) => UserActionResponse(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.toJson();
    }
    return map;
  }

}

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());
class Message {
  Message({
      this.actionResponseList,});

  Message.fromJson(dynamic json) {
    if (json['action_response_list'] != null) {
      actionResponseList = [];
      json['action_response_list'].forEach((v) {
        actionResponseList?.add(ActionResponseList.fromJson(v));
      });
    }
  }
  List<ActionResponseList>? actionResponseList;
Message copyWith({  List<ActionResponseList>? actionResponseList,
}) => Message(  actionResponseList: actionResponseList ?? this.actionResponseList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (actionResponseList != null) {
      map['action_response_list'] = actionResponseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ActionResponseList actionResponseListFromJson(String str) => ActionResponseList.fromJson(json.decode(str));
String actionResponseListToJson(ActionResponseList data) => json.encode(data.toJson());
class ActionResponseList {
  ActionResponseList({
      this.userId, 
      this.matchOccurred, 
      this.matchId,});

  ActionResponseList.fromJson(dynamic json) {
    userId = json['user_id'];
    matchOccurred = json['match_occurred'];
    matchId = json['match_id'];
  }
  int? userId;
  bool? matchOccurred;
  int? matchId;
ActionResponseList copyWith({  int? userId,
  bool? matchOccurred,
  int? matchId,
}) => ActionResponseList(  userId: userId ?? this.userId,
  matchOccurred: matchOccurred ?? this.matchOccurred,
  matchId: matchId ?? this.matchId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['match_occurred'] = matchOccurred;
    map['match_id'] = matchId;
    return map;
  }

}