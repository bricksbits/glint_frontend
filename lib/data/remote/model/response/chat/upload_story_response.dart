import 'dart:convert';
UploadStoryResponse uploadStoryResponseFromJson(String str) => UploadStoryResponse.fromJson(json.decode(str));
String uploadStoryResponseToJson(UploadStoryResponse data) => json.encode(data.toJson());
class UploadStoryResponse {
  UploadStoryResponse({
      this.filesUploaded, 
      this.filesNotUploaded,});

  UploadStoryResponse.fromJson(dynamic json) {
    filesUploaded = json['files_uploaded'] != null ? json['files_uploaded'].cast<String>() : [];
    if (json['files_not_uploaded'] != null) {
      filesNotUploaded = [];
      json['files_not_uploaded'].forEach((v) {
        filesNotUploaded?.add(Dynamic.fromJson(v));
      });
    }
  }
  List<String>? filesUploaded;
  List<dynamic>? filesNotUploaded;
UploadStoryResponse copyWith({  List<String>? filesUploaded,
  List<dynamic>? filesNotUploaded,
}) => UploadStoryResponse(  filesUploaded: filesUploaded ?? this.filesUploaded,
  filesNotUploaded: filesNotUploaded ?? this.filesNotUploaded,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['files_uploaded'] = filesUploaded;
    if (filesNotUploaded != null) {
      map['files_not_uploaded'] = filesNotUploaded?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}