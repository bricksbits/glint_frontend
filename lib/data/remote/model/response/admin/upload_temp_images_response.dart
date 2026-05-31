import 'dart:convert';

UploadTempImagesResponse uploadTempImagesResponseFromJson(String str) =>
    UploadTempImagesResponse.fromJson(json.decode(str));

class UploadTempImagesResponse {
  UploadTempImagesResponse({
    this.tempId,
    this.filesUploaded,
    this.filesNotUploaded,
  });

  UploadTempImagesResponse.fromJson(dynamic json) {
    tempId = json['temp_id'];
    filesUploaded = json['files_uploaded'] != null
        ? json['files_uploaded'].cast<String>()
        : [];
    filesNotUploaded = json['files_not_uploaded'] != null
        ? json['files_not_uploaded'].cast<String>()
        : [];
  }

  String? tempId;
  List<String>? filesUploaded;
  List<String>? filesNotUploaded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp_id'] = tempId;
    map['files_uploaded'] = filesUploaded;
    map['files_not_uploaded'] = filesNotUploaded;
    return map;
  }
}
