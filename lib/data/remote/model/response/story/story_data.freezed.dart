// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryData _$StoryDataFromJson(Map<String, dynamic> json) {
  return _StoryData.fromJson(json);
}

/// @nodoc
mixin _$StoryData {
  @JsonKey(name: 'story_url_list')
  List<StoryUrl> get storyUrlList => throw _privateConstructorUsedError;
  @JsonKey(name: 'stream_chat_channel_id')
  String get streamChatChannelId => throw _privateConstructorUsedError;

  /// Serializes this StoryData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryDataCopyWith<StoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDataCopyWith<$Res> {
  factory $StoryDataCopyWith(StoryData value, $Res Function(StoryData) then) =
      _$StoryDataCopyWithImpl<$Res, StoryData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'story_url_list') List<StoryUrl> storyUrlList,
      @JsonKey(name: 'stream_chat_channel_id') String streamChatChannelId});
}

/// @nodoc
class _$StoryDataCopyWithImpl<$Res, $Val extends StoryData>
    implements $StoryDataCopyWith<$Res> {
  _$StoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyUrlList = null,
    Object? streamChatChannelId = null,
  }) {
    return _then(_value.copyWith(
      storyUrlList: null == storyUrlList
          ? _value.storyUrlList
          : storyUrlList // ignore: cast_nullable_to_non_nullable
              as List<StoryUrl>,
      streamChatChannelId: null == streamChatChannelId
          ? _value.streamChatChannelId
          : streamChatChannelId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryDataImplCopyWith<$Res>
    implements $StoryDataCopyWith<$Res> {
  factory _$$StoryDataImplCopyWith(
          _$StoryDataImpl value, $Res Function(_$StoryDataImpl) then) =
      __$$StoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'story_url_list') List<StoryUrl> storyUrlList,
      @JsonKey(name: 'stream_chat_channel_id') String streamChatChannelId});
}

/// @nodoc
class __$$StoryDataImplCopyWithImpl<$Res>
    extends _$StoryDataCopyWithImpl<$Res, _$StoryDataImpl>
    implements _$$StoryDataImplCopyWith<$Res> {
  __$$StoryDataImplCopyWithImpl(
      _$StoryDataImpl _value, $Res Function(_$StoryDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyUrlList = null,
    Object? streamChatChannelId = null,
  }) {
    return _then(_$StoryDataImpl(
      storyUrlList: null == storyUrlList
          ? _value._storyUrlList
          : storyUrlList // ignore: cast_nullable_to_non_nullable
              as List<StoryUrl>,
      streamChatChannelId: null == streamChatChannelId
          ? _value.streamChatChannelId
          : streamChatChannelId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDataImpl implements _StoryData {
  const _$StoryDataImpl(
      {@JsonKey(name: 'story_url_list')
      required final List<StoryUrl> storyUrlList,
      @JsonKey(name: 'stream_chat_channel_id')
      required this.streamChatChannelId})
      : _storyUrlList = storyUrlList;

  factory _$StoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDataImplFromJson(json);

  final List<StoryUrl> _storyUrlList;
  @override
  @JsonKey(name: 'story_url_list')
  List<StoryUrl> get storyUrlList {
    if (_storyUrlList is EqualUnmodifiableListView) return _storyUrlList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storyUrlList);
  }

  @override
  @JsonKey(name: 'stream_chat_channel_id')
  final String streamChatChannelId;

  @override
  String toString() {
    return 'StoryData(storyUrlList: $storyUrlList, streamChatChannelId: $streamChatChannelId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDataImpl &&
            const DeepCollectionEquality()
                .equals(other._storyUrlList, _storyUrlList) &&
            (identical(other.streamChatChannelId, streamChatChannelId) ||
                other.streamChatChannelId == streamChatChannelId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_storyUrlList), streamChatChannelId);

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      __$$StoryDataImplCopyWithImpl<_$StoryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDataImplToJson(
      this,
    );
  }
}

abstract class _StoryData implements StoryData {
  const factory _StoryData(
      {@JsonKey(name: 'story_url_list')
      required final List<StoryUrl> storyUrlList,
      @JsonKey(name: 'stream_chat_channel_id')
      required final String streamChatChannelId}) = _$StoryDataImpl;

  factory _StoryData.fromJson(Map<String, dynamic> json) =
      _$StoryDataImpl.fromJson;

  @override
  @JsonKey(name: 'story_url_list')
  List<StoryUrl> get storyUrlList;
  @override
  @JsonKey(name: 'stream_chat_channel_id')
  String get streamChatChannelId;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
