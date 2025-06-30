import 'dart:convert';
StoryUploadResponse storyUploadResponseFromJson(String str) => StoryUploadResponse.fromJson(json.decode(str));
String storyUploadResponseToJson(StoryUploadResponse data) => json.encode(data.toJson());
class StoryUploadResponse {
  StoryUploadResponse({
      this.filesUploaded, 
      this.filesNotUploaded,});

  StoryUploadResponse.fromJson(dynamic json) {
    filesUploaded = json['files_uploaded'] != null ? json['files_uploaded'].cast<String>() : [];
    filesNotUploaded = json['files_not_uploaded'] != null ? json['files_not_uploaded'].cast<String>() : [];
  }
  List<String>? filesUploaded;
  List<String>? filesNotUploaded;
StoryUploadResponse copyWith({  List<String>? filesUploaded,
  List<String>? filesNotUploaded,
}) => StoryUploadResponse(  filesUploaded: filesUploaded ?? this.filesUploaded,
  filesNotUploaded: filesNotUploaded ?? this.filesNotUploaded,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['files_uploaded'] = filesUploaded;
    map['files_not_uploaded'] = filesNotUploaded;
    return map;
  }

}