import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_url.freezed.dart';
part 'story_url.g.dart';

@freezed
class StoryUrl with _$StoryUrl {
  const factory StoryUrl({
    @JsonKey(name: 'presigned_url') required String presignedUrl,
    @JsonKey(name: 'file_extension') required String fileExtension,
  }) = _StoryUrl;

  factory StoryUrl.fromJson(Map<String, dynamic> json) =>
      _$StoryUrlFromJson(json);
}
