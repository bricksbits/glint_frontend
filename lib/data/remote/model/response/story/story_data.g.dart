// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryDataImpl _$$StoryDataImplFromJson(Map<String, dynamic> json) =>
    _$StoryDataImpl(
      storyUrlList: (json['story_url_list'] as List<dynamic>)
          .map((e) => StoryUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      streamChatChannelId: json['stream_chat_channel_id'] as String,
    );

Map<String, dynamic> _$$StoryDataImplToJson(_$StoryDataImpl instance) =>
    <String, dynamic>{
      'story_url_list': instance.storyUrlList,
      'stream_chat_channel_id': instance.streamChatChannelId,
    };
