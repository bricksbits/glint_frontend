// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryUrl _$StoryUrlFromJson(Map<String, dynamic> json) {
  return _StoryUrl.fromJson(json);
}

/// @nodoc
mixin _$StoryUrl {
  @JsonKey(name: 'presigned_url')
  String get presignedUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_extension')
  String get fileExtension => throw _privateConstructorUsedError;

  /// Serializes this StoryUrl to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryUrl
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryUrlCopyWith<StoryUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryUrlCopyWith<$Res> {
  factory $StoryUrlCopyWith(StoryUrl value, $Res Function(StoryUrl) then) =
      _$StoryUrlCopyWithImpl<$Res, StoryUrl>;
  @useResult
  $Res call(
      {@JsonKey(name: 'presigned_url') String presignedUrl,
      @JsonKey(name: 'file_extension') String fileExtension});
}

/// @nodoc
class _$StoryUrlCopyWithImpl<$Res, $Val extends StoryUrl>
    implements $StoryUrlCopyWith<$Res> {
  _$StoryUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryUrl
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presignedUrl = null,
    Object? fileExtension = null,
  }) {
    return _then(_value.copyWith(
      presignedUrl: null == presignedUrl
          ? _value.presignedUrl
          : presignedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileExtension: null == fileExtension
          ? _value.fileExtension
          : fileExtension // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryUrlImplCopyWith<$Res>
    implements $StoryUrlCopyWith<$Res> {
  factory _$$StoryUrlImplCopyWith(
          _$StoryUrlImpl value, $Res Function(_$StoryUrlImpl) then) =
      __$$StoryUrlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'presigned_url') String presignedUrl,
      @JsonKey(name: 'file_extension') String fileExtension});
}

/// @nodoc
class __$$StoryUrlImplCopyWithImpl<$Res>
    extends _$StoryUrlCopyWithImpl<$Res, _$StoryUrlImpl>
    implements _$$StoryUrlImplCopyWith<$Res> {
  __$$StoryUrlImplCopyWithImpl(
      _$StoryUrlImpl _value, $Res Function(_$StoryUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryUrl
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presignedUrl = null,
    Object? fileExtension = null,
  }) {
    return _then(_$StoryUrlImpl(
      presignedUrl: null == presignedUrl
          ? _value.presignedUrl
          : presignedUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileExtension: null == fileExtension
          ? _value.fileExtension
          : fileExtension // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryUrlImpl implements _StoryUrl {
  const _$StoryUrlImpl(
      {@JsonKey(name: 'presigned_url') required this.presignedUrl,
      @JsonKey(name: 'file_extension') required this.fileExtension});

  factory _$StoryUrlImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryUrlImplFromJson(json);

  @override
  @JsonKey(name: 'presigned_url')
  final String presignedUrl;
  @override
  @JsonKey(name: 'file_extension')
  final String fileExtension;

  @override
  String toString() {
    return 'StoryUrl(presignedUrl: $presignedUrl, fileExtension: $fileExtension)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryUrlImpl &&
            (identical(other.presignedUrl, presignedUrl) ||
                other.presignedUrl == presignedUrl) &&
            (identical(other.fileExtension, fileExtension) ||
                other.fileExtension == fileExtension));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, presignedUrl, fileExtension);

  /// Create a copy of StoryUrl
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryUrlImplCopyWith<_$StoryUrlImpl> get copyWith =>
      __$$StoryUrlImplCopyWithImpl<_$StoryUrlImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryUrlImplToJson(
      this,
    );
  }
}

abstract class _StoryUrl implements StoryUrl {
  const factory _StoryUrl(
      {@JsonKey(name: 'presigned_url') required final String presignedUrl,
      @JsonKey(name: 'file_extension')
      required final String fileExtension}) = _$StoryUrlImpl;

  factory _StoryUrl.fromJson(Map<String, dynamic> json) =
      _$StoryUrlImpl.fromJson;

  @override
  @JsonKey(name: 'presigned_url')
  String get presignedUrl;
  @override
  @JsonKey(name: 'file_extension')
  String get fileExtension;

  /// Create a copy of StoryUrl
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryUrlImplCopyWith<_$StoryUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
