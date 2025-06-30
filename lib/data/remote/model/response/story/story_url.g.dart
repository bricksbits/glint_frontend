// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryUrlImpl _$$StoryUrlImplFromJson(Map<String, dynamic> json) =>
    _$StoryUrlImpl(
      presignedUrl: json['presigned_url'] as String,
      fileExtension: json['file_extension'] as String,
    );

Map<String, dynamic> _$$StoryUrlImplToJson(_$StoryUrlImpl instance) =>
    <String, dynamic>{
      'presigned_url': instance.presignedUrl,
      'file_extension': instance.fileExtension,
    };
