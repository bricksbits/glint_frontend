// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_story_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UploadStoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadStoryEventCopyWith<$Res> {
  factory $UploadStoryEventCopyWith(
          UploadStoryEvent value, $Res Function(UploadStoryEvent) then) =
      _$UploadStoryEventCopyWithImpl<$Res, UploadStoryEvent>;
}

/// @nodoc
class _$UploadStoryEventCopyWithImpl<$Res, $Val extends UploadStoryEvent>
    implements $UploadStoryEventCopyWith<$Res> {
  _$UploadStoryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'UploadStoryEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements UploadStoryEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
mixin _$UploadStoryState {
  List<String> get storiesFilePath => throw _privateConstructorUsedError;
  String get currentStoryPath => throw _privateConstructorUsedError;
  int get profileViewCount => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  String? get currentUploadedFilePath => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)
        uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)?
        uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)?
        uploadStoryState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStoryState value) uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStoryState value)? uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStoryState value)? uploadStoryState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadStoryStateCopyWith<UploadStoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadStoryStateCopyWith<$Res> {
  factory $UploadStoryStateCopyWith(
          UploadStoryState value, $Res Function(UploadStoryState) then) =
      _$UploadStoryStateCopyWithImpl<$Res, UploadStoryState>;
  @useResult
  $Res call(
      {List<String> storiesFilePath,
      String currentStoryPath,
      int profileViewCount,
      String userName,
      String imageUrl,
      bool isVerified,
      String? currentUploadedFilePath});
}

/// @nodoc
class _$UploadStoryStateCopyWithImpl<$Res, $Val extends UploadStoryState>
    implements $UploadStoryStateCopyWith<$Res> {
  _$UploadStoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storiesFilePath = null,
    Object? currentStoryPath = null,
    Object? profileViewCount = null,
    Object? userName = null,
    Object? imageUrl = null,
    Object? isVerified = null,
    Object? currentUploadedFilePath = freezed,
  }) {
    return _then(_value.copyWith(
      storiesFilePath: null == storiesFilePath
          ? _value.storiesFilePath
          : storiesFilePath // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStoryPath: null == currentStoryPath
          ? _value.currentStoryPath
          : currentStoryPath // ignore: cast_nullable_to_non_nullable
              as String,
      profileViewCount: null == profileViewCount
          ? _value.profileViewCount
          : profileViewCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUploadedFilePath: freezed == currentUploadedFilePath
          ? _value.currentUploadedFilePath
          : currentUploadedFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadStoryStateImplCopyWith<$Res>
    implements $UploadStoryStateCopyWith<$Res> {
  factory _$$UploadStoryStateImplCopyWith(_$UploadStoryStateImpl value,
          $Res Function(_$UploadStoryStateImpl) then) =
      __$$UploadStoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> storiesFilePath,
      String currentStoryPath,
      int profileViewCount,
      String userName,
      String imageUrl,
      bool isVerified,
      String? currentUploadedFilePath});
}

/// @nodoc
class __$$UploadStoryStateImplCopyWithImpl<$Res>
    extends _$UploadStoryStateCopyWithImpl<$Res, _$UploadStoryStateImpl>
    implements _$$UploadStoryStateImplCopyWith<$Res> {
  __$$UploadStoryStateImplCopyWithImpl(_$UploadStoryStateImpl _value,
      $Res Function(_$UploadStoryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storiesFilePath = null,
    Object? currentStoryPath = null,
    Object? profileViewCount = null,
    Object? userName = null,
    Object? imageUrl = null,
    Object? isVerified = null,
    Object? currentUploadedFilePath = freezed,
  }) {
    return _then(_$UploadStoryStateImpl(
      storiesFilePath: null == storiesFilePath
          ? _value._storiesFilePath
          : storiesFilePath // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStoryPath: null == currentStoryPath
          ? _value.currentStoryPath
          : currentStoryPath // ignore: cast_nullable_to_non_nullable
              as String,
      profileViewCount: null == profileViewCount
          ? _value.profileViewCount
          : profileViewCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUploadedFilePath: freezed == currentUploadedFilePath
          ? _value.currentUploadedFilePath
          : currentUploadedFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UploadStoryStateImpl implements _UploadStoryState {
  const _$UploadStoryStateImpl(
      {final List<String> storiesFilePath = const [],
      this.currentStoryPath = "",
      this.profileViewCount = 0,
      this.userName = "",
      this.imageUrl = "",
      this.isVerified = false,
      this.currentUploadedFilePath = ""})
      : _storiesFilePath = storiesFilePath;

  final List<String> _storiesFilePath;
  @override
  @JsonKey()
  List<String> get storiesFilePath {
    if (_storiesFilePath is EqualUnmodifiableListView) return _storiesFilePath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storiesFilePath);
  }

  @override
  @JsonKey()
  final String currentStoryPath;
  @override
  @JsonKey()
  final int profileViewCount;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final String? currentUploadedFilePath;

  @override
  String toString() {
    return 'UploadStoryState.uploadStoryState(storiesFilePath: $storiesFilePath, currentStoryPath: $currentStoryPath, profileViewCount: $profileViewCount, userName: $userName, imageUrl: $imageUrl, isVerified: $isVerified, currentUploadedFilePath: $currentUploadedFilePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadStoryStateImpl &&
            const DeepCollectionEquality()
                .equals(other._storiesFilePath, _storiesFilePath) &&
            (identical(other.currentStoryPath, currentStoryPath) ||
                other.currentStoryPath == currentStoryPath) &&
            (identical(other.profileViewCount, profileViewCount) ||
                other.profileViewCount == profileViewCount) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(
                    other.currentUploadedFilePath, currentUploadedFilePath) ||
                other.currentUploadedFilePath == currentUploadedFilePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_storiesFilePath),
      currentStoryPath,
      profileViewCount,
      userName,
      imageUrl,
      isVerified,
      currentUploadedFilePath);

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadStoryStateImplCopyWith<_$UploadStoryStateImpl> get copyWith =>
      __$$UploadStoryStateImplCopyWithImpl<_$UploadStoryStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)
        uploadStoryState,
  }) {
    return uploadStoryState(storiesFilePath, currentStoryPath, profileViewCount,
        userName, imageUrl, isVerified, currentUploadedFilePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)?
        uploadStoryState,
  }) {
    return uploadStoryState?.call(
        storiesFilePath,
        currentStoryPath,
        profileViewCount,
        userName,
        imageUrl,
        isVerified,
        currentUploadedFilePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> storiesFilePath,
            String currentStoryPath,
            int profileViewCount,
            String userName,
            String imageUrl,
            bool isVerified,
            String? currentUploadedFilePath)?
        uploadStoryState,
    required TResult orElse(),
  }) {
    if (uploadStoryState != null) {
      return uploadStoryState(
          storiesFilePath,
          currentStoryPath,
          profileViewCount,
          userName,
          imageUrl,
          isVerified,
          currentUploadedFilePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStoryState value) uploadStoryState,
  }) {
    return uploadStoryState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStoryState value)? uploadStoryState,
  }) {
    return uploadStoryState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStoryState value)? uploadStoryState,
    required TResult orElse(),
  }) {
    if (uploadStoryState != null) {
      return uploadStoryState(this);
    }
    return orElse();
  }
}

abstract class _UploadStoryState implements UploadStoryState {
  const factory _UploadStoryState(
      {final List<String> storiesFilePath,
      final String currentStoryPath,
      final int profileViewCount,
      final String userName,
      final String imageUrl,
      final bool isVerified,
      final String? currentUploadedFilePath}) = _$UploadStoryStateImpl;

  @override
  List<String> get storiesFilePath;
  @override
  String get currentStoryPath;
  @override
  int get profileViewCount;
  @override
  String get userName;
  @override
  String get imageUrl;
  @override
  bool get isVerified;
  @override
  String? get currentUploadedFilePath;

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadStoryStateImplCopyWith<_$UploadStoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
