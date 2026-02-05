import 'dart:convert';
SuperDmResponseBody superDmResponseBodyFromJson(String str) => SuperDmResponseBody.fromJson(json.decode(str));
String superDmResponseBodyToJson(SuperDmResponseBody data) => json.encode(data.toJson());
class SuperDmResponseBody {
  SuperDmResponseBody({
      this.success, 
      this.message, 
      this.data,});

  SuperDmResponseBody.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
SuperDmResponseBody copyWith({  bool? success,
  String? message,
  Data? data,
}) => SuperDmResponseBody(  success: success ?? this.success,
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
      this.streamChatChannelId,});

  Data.fromJson(dynamic json) {
    streamChatChannelId = json['stream_chat_channel_id'];
  }
  String? streamChatChannelId;
Data copyWith({  String? streamChatChannelId,
}) => Data(  streamChatChannelId: streamChatChannelId ?? this.streamChatChannelId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stream_chat_channel_id'] = streamChatChannelId;
    return map;
  }

}