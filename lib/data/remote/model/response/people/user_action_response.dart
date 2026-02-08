import 'dart:convert';
UserActionResponse userActionResponseFromJson(String str) => UserActionResponse.fromJson(json.decode(str));
String userActionResponseToJson(UserActionResponse data) => json.encode(data.toJson());
class UserActionResponse {
  UserActionResponse({
      this.success, 
      this.message, 
      this.data,});

  UserActionResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
UserActionResponse copyWith({  bool? success,
  String? message,
  Data? data,
}) => UserActionResponse(  success: success ?? this.success,
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
      this.actionResponseList,});

  Data.fromJson(dynamic json) {
    if (json['action_response_list'] != null) {
      actionResponseList = [];
      json['action_response_list'].forEach((v) {
        actionResponseList?.add(ActionResponseList.fromJson(v));
      });
    }
  }
  List<ActionResponseList>? actionResponseList;
Data copyWith({  List<ActionResponseList>? actionResponseList,
}) => Data(  actionResponseList: actionResponseList ?? this.actionResponseList,
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