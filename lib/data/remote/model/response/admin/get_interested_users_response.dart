import 'dart:convert';
GetInterestedUsersResponse getInterestedUsersResponseFromJson(String str) => GetInterestedUsersResponse.fromJson(json.decode(str));
String getInterestedUsersResponseToJson(GetInterestedUsersResponse data) => json.encode(data.toJson());
class GetInterestedUsersResponse {
  GetInterestedUsersResponse({
      this.response,});

  GetInterestedUsersResponse.fromJson(dynamic json) {
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  List<Response>? response;
GetInterestedUsersResponse copyWith({  List<Response>? response,
}) => GetInterestedUsersResponse(  response: response ?? this.response,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));
String responseToJson(Response data) => json.encode(data.toJson());
class Response {
  Response({
      this.userId, 
      this.username, 
      this.emailId, 
      this.profilePicture,});

  Response.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
    emailId = json['email_id'];
    profilePicture = json['profile_picture'] != null ? ProfilePicture.fromJson(json['profile_picture']) : null;
  }
  int? userId;
  String? username;
  String? emailId;
  ProfilePicture? profilePicture;
Response copyWith({  int? userId,
  String? username,
  String? emailId,
  ProfilePicture? profilePicture,
}) => Response(  userId: userId ?? this.userId,
  username: username ?? this.username,
  emailId: emailId ?? this.emailId,
  profilePicture: profilePicture ?? this.profilePicture,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = username;
    map['email_id'] = emailId;
    if (profilePicture != null) {
      map['profile_picture'] = profilePicture?.toJson();
    }
    return map;
  }

}

ProfilePicture profilePictureFromJson(String str) => ProfilePicture.fromJson(json.decode(str));
String profilePictureToJson(ProfilePicture data) => json.encode(data.toJson());
class ProfilePicture {
  ProfilePicture({
      this.presignedUrl, 
      this.fileExtension,});

  ProfilePicture.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
ProfilePicture copyWith({  String? presignedUrl,
  String? fileExtension,
}) => ProfilePicture(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}