// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) {
  return _StoryResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryResponse {
  Map<String, StoryData> get story => throw _privateConstructorUsedError;

  /// Serializes this StoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryResponseCopyWith<StoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryResponseCopyWith<$Res> {
  factory $StoryResponseCopyWith(
          StoryResponse value, $Res Function(StoryResponse) then) =
      _$StoryResponseCopyWithImpl<$Res, StoryResponse>;
  @useResult
  $Res call({Map<String, StoryData> story});
}

/// @nodoc
class _$StoryResponseCopyWithImpl<$Res, $Val extends StoryResponse>
    implements $StoryResponseCopyWith<$Res> {
  _$StoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? story = null,
  }) {
    return _then(_value.copyWith(
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Map<String, StoryData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryResponseImplCopyWith<$Res>
    implements $StoryResponseCopyWith<$Res> {
  factory _$$StoryResponseImplCopyWith(
          _$StoryResponseImpl value, $Res Function(_$StoryResponseImpl) then) =
      __$$StoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, StoryData> story});
}

/// @nodoc
class __$$StoryResponseImplCopyWithImpl<$Res>
    extends _$StoryResponseCopyWithImpl<$Res, _$StoryResponseImpl>
    implements _$$StoryResponseImplCopyWith<$Res> {
  __$$StoryResponseImplCopyWithImpl(
      _$StoryResponseImpl _value, $Res Function(_$StoryResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? story = null,
  }) {
    return _then(_$StoryResponseImpl(
      story: null == story
          ? _value._story
          : story // ignore: cast_nullable_to_non_nullable
              as Map<String, StoryData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryResponseImpl implements _StoryResponse {
  const _$StoryResponseImpl({required final Map<String, StoryData> story})
      : _story = story;

  factory _$StoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryResponseImplFromJson(json);

  final Map<String, StoryData> _story;
  @override
  Map<String, StoryData> get story {
    if (_story is EqualUnmodifiableMapView) return _story;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_story);
  }

  @override
  String toString() {
    return 'StoryResponse(story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryResponseImpl &&
            const DeepCollectionEquality().equals(other._story, _story));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_story));

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryResponseImplCopyWith<_$StoryResponseImpl> get copyWith =>
      __$$StoryResponseImplCopyWithImpl<_$StoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryResponseImplToJson(
      this,
    );
  }
}

abstract class _StoryResponse implements StoryResponse {
  const factory _StoryResponse({required final Map<String, StoryData> story}) =
      _$StoryResponseImpl;

  factory _StoryResponse.fromJson(Map<String, dynamic> json) =
      _$StoryResponseImpl.fromJson;

  @override
  Map<String, StoryData> get story;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryResponseImplCopyWith<_$StoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
