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
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
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
abstract class _$$UploadStoryImplCopyWith<$Res> {
  factory _$$UploadStoryImplCopyWith(
          _$UploadStoryImpl value, $Res Function(_$UploadStoryImpl) then) =
      __$$UploadStoryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UploadStoryImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$UploadStoryImpl>
    implements _$$UploadStoryImplCopyWith<$Res> {
  __$$UploadStoryImplCopyWithImpl(
      _$UploadStoryImpl _value, $Res Function(_$UploadStoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UploadStoryImpl implements _UploadStory {
  const _$UploadStoryImpl();

  @override
  String toString() {
    return 'UploadStoryEvent.uploadStory()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UploadStoryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) {
    return uploadStory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) {
    return uploadStory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (uploadStory != null) {
      return uploadStory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) {
    return uploadStory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) {
    return uploadStory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (uploadStory != null) {
      return uploadStory(this);
    }
    return orElse();
  }
}

abstract class _UploadStory implements UploadStoryEvent {
  const factory _UploadStory() = _$UploadStoryImpl;
}

/// @nodoc
abstract class _$$CurrentUserStoriesImplCopyWith<$Res> {
  factory _$$CurrentUserStoriesImplCopyWith(_$CurrentUserStoriesImpl value,
          $Res Function(_$CurrentUserStoriesImpl) then) =
      __$$CurrentUserStoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CurrentUserStoriesImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$CurrentUserStoriesImpl>
    implements _$$CurrentUserStoriesImplCopyWith<$Res> {
  __$$CurrentUserStoriesImplCopyWithImpl(_$CurrentUserStoriesImpl _value,
      $Res Function(_$CurrentUserStoriesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CurrentUserStoriesImpl implements _CurrentUserStories {
  const _$CurrentUserStoriesImpl();

  @override
  String toString() {
    return 'UploadStoryEvent.getCurrentUserStories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CurrentUserStoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) {
    return getCurrentUserStories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) {
    return getCurrentUserStories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (getCurrentUserStories != null) {
      return getCurrentUserStories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) {
    return getCurrentUserStories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) {
    return getCurrentUserStories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (getCurrentUserStories != null) {
      return getCurrentUserStories(this);
    }
    return orElse();
  }
}

abstract class _CurrentUserStories implements UploadStoryEvent {
  const factory _CurrentUserStories() = _$CurrentUserStoriesImpl;
}

/// @nodoc
abstract class _$$UpdateAndEmitNewStateImplCopyWith<$Res> {
  factory _$$UpdateAndEmitNewStateImplCopyWith(
          _$UpdateAndEmitNewStateImpl value,
          $Res Function(_$UpdateAndEmitNewStateImpl) then) =
      __$$UpdateAndEmitNewStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UploadStoryState newState});

  $UploadStoryStateCopyWith<$Res> get newState;
}

/// @nodoc
class __$$UpdateAndEmitNewStateImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$UpdateAndEmitNewStateImpl>
    implements _$$UpdateAndEmitNewStateImplCopyWith<$Res> {
  __$$UpdateAndEmitNewStateImplCopyWithImpl(_$UpdateAndEmitNewStateImpl _value,
      $Res Function(_$UpdateAndEmitNewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newState = null,
  }) {
    return _then(_$UpdateAndEmitNewStateImpl(
      null == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as UploadStoryState,
    ));
  }

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UploadStoryStateCopyWith<$Res> get newState {
    return $UploadStoryStateCopyWith<$Res>(_value.newState, (value) {
      return _then(_value.copyWith(newState: value));
    });
  }
}

/// @nodoc

class _$UpdateAndEmitNewStateImpl implements _UpdateAndEmitNewState {
  const _$UpdateAndEmitNewStateImpl(this.newState);

  @override
  final UploadStoryState newState;

  @override
  String toString() {
    return 'UploadStoryEvent.updateStateAndEmit(newState: $newState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAndEmitNewStateImpl &&
            (identical(other.newState, newState) ||
                other.newState == newState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newState);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAndEmitNewStateImplCopyWith<_$UpdateAndEmitNewStateImpl>
      get copyWith => __$$UpdateAndEmitNewStateImplCopyWithImpl<
          _$UpdateAndEmitNewStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) {
    return updateStateAndEmit(newState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) {
    return updateStateAndEmit?.call(newState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (updateStateAndEmit != null) {
      return updateStateAndEmit(newState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) {
    return updateStateAndEmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) {
    return updateStateAndEmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (updateStateAndEmit != null) {
      return updateStateAndEmit(this);
    }
    return orElse();
  }
}

abstract class _UpdateAndEmitNewState implements UploadStoryEvent {
  const factory _UpdateAndEmitNewState(final UploadStoryState newState) =
      _$UpdateAndEmitNewStateImpl;

  UploadStoryState get newState;

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateAndEmitNewStateImplCopyWith<_$UpdateAndEmitNewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteUserStoryImplCopyWith<$Res> {
  factory _$$DeleteUserStoryImplCopyWith(_$DeleteUserStoryImpl value,
          $Res Function(_$DeleteUserStoryImpl) then) =
      __$$DeleteUserStoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fileName});
}

/// @nodoc
class __$$DeleteUserStoryImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$DeleteUserStoryImpl>
    implements _$$DeleteUserStoryImplCopyWith<$Res> {
  __$$DeleteUserStoryImplCopyWithImpl(
      _$DeleteUserStoryImpl _value, $Res Function(_$DeleteUserStoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
  }) {
    return _then(_$DeleteUserStoryImpl(
      null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteUserStoryImpl implements _DeleteUserStory {
  const _$DeleteUserStoryImpl(this.fileName);

  @override
  final String fileName;

  @override
  String toString() {
    return 'UploadStoryEvent.deleteUserStory(fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteUserStoryImpl &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fileName);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteUserStoryImplCopyWith<_$DeleteUserStoryImpl> get copyWith =>
      __$$DeleteUserStoryImplCopyWithImpl<_$DeleteUserStoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) {
    return deleteUserStory(fileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) {
    return deleteUserStory?.call(fileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (deleteUserStory != null) {
      return deleteUserStory(fileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) {
    return deleteUserStory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) {
    return deleteUserStory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (deleteUserStory != null) {
      return deleteUserStory(this);
    }
    return orElse();
  }
}

abstract class _DeleteUserStory implements UploadStoryEvent {
  const factory _DeleteUserStory(final String fileName) = _$DeleteUserStoryImpl;

  String get fileName;

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteUserStoryImplCopyWith<_$DeleteUserStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectStoryFromGalleryImplCopyWith<$Res> {
  factory _$$SelectStoryFromGalleryImplCopyWith(
          _$SelectStoryFromGalleryImpl value,
          $Res Function(_$SelectStoryFromGalleryImpl) then) =
      __$$SelectStoryFromGalleryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SelectStoryFromGalleryImplCopyWithImpl<$Res>
    extends _$UploadStoryEventCopyWithImpl<$Res, _$SelectStoryFromGalleryImpl>
    implements _$$SelectStoryFromGalleryImplCopyWith<$Res> {
  __$$SelectStoryFromGalleryImplCopyWithImpl(
      _$SelectStoryFromGalleryImpl _value,
      $Res Function(_$SelectStoryFromGalleryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadStoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SelectStoryFromGalleryImpl implements _SelectStoryFromGallery {
  const _$SelectStoryFromGalleryImpl();

  @override
  String toString() {
    return 'UploadStoryEvent.selectStoryFromGallery()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectStoryFromGalleryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadStory,
    required TResult Function() getCurrentUserStories,
    required TResult Function(UploadStoryState newState) updateStateAndEmit,
    required TResult Function(String fileName) deleteUserStory,
    required TResult Function() selectStoryFromGallery,
  }) {
    return selectStoryFromGallery();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadStory,
    TResult? Function()? getCurrentUserStories,
    TResult? Function(UploadStoryState newState)? updateStateAndEmit,
    TResult? Function(String fileName)? deleteUserStory,
    TResult? Function()? selectStoryFromGallery,
  }) {
    return selectStoryFromGallery?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadStory,
    TResult Function()? getCurrentUserStories,
    TResult Function(UploadStoryState newState)? updateStateAndEmit,
    TResult Function(String fileName)? deleteUserStory,
    TResult Function()? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (selectStoryFromGallery != null) {
      return selectStoryFromGallery();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadStory value) uploadStory,
    required TResult Function(_CurrentUserStories value) getCurrentUserStories,
    required TResult Function(_UpdateAndEmitNewState value) updateStateAndEmit,
    required TResult Function(_DeleteUserStory value) deleteUserStory,
    required TResult Function(_SelectStoryFromGallery value)
        selectStoryFromGallery,
  }) {
    return selectStoryFromGallery(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UploadStory value)? uploadStory,
    TResult? Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult? Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult? Function(_DeleteUserStory value)? deleteUserStory,
    TResult? Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
  }) {
    return selectStoryFromGallery?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadStory value)? uploadStory,
    TResult Function(_CurrentUserStories value)? getCurrentUserStories,
    TResult Function(_UpdateAndEmitNewState value)? updateStateAndEmit,
    TResult Function(_DeleteUserStory value)? deleteUserStory,
    TResult Function(_SelectStoryFromGallery value)? selectStoryFromGallery,
    required TResult orElse(),
  }) {
    if (selectStoryFromGallery != null) {
      return selectStoryFromGallery(this);
    }
    return orElse();
  }
}

abstract class _SelectStoryFromGallery implements UploadStoryEvent {
  const factory _SelectStoryFromGallery() = _$SelectStoryFromGalleryImpl;
}

/// @nodoc
mixin _$UploadStoryState {
// When Viewing the Stories
  ViewStoryModel? get uploadedStories =>
      throw _privateConstructorUsedError; // When uploading the Story
  String get userName => throw _privateConstructorUsedError;
  String get userCircularAvatarUrl => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  File? get currentUploadedFile =>
      throw _privateConstructorUsedError; // General
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get newUserStoryUploadSuccess => throw _privateConstructorUsedError;
  bool get newUserStoryUploadFail => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)
        uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)?
        uploadStoryState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)?
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
      {ViewStoryModel? uploadedStories,
      String userName,
      String userCircularAvatarUrl,
      bool isVerified,
      File? currentUploadedFile,
      bool isLoading,
      String? error,
      bool newUserStoryUploadSuccess,
      bool newUserStoryUploadFail});
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
    Object? uploadedStories = freezed,
    Object? userName = null,
    Object? userCircularAvatarUrl = null,
    Object? isVerified = null,
    Object? currentUploadedFile = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? newUserStoryUploadSuccess = null,
    Object? newUserStoryUploadFail = null,
  }) {
    return _then(_value.copyWith(
      uploadedStories: freezed == uploadedStories
          ? _value.uploadedStories
          : uploadedStories // ignore: cast_nullable_to_non_nullable
              as ViewStoryModel?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userCircularAvatarUrl: null == userCircularAvatarUrl
          ? _value.userCircularAvatarUrl
          : userCircularAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUploadedFile: freezed == currentUploadedFile
          ? _value.currentUploadedFile
          : currentUploadedFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      newUserStoryUploadSuccess: null == newUserStoryUploadSuccess
          ? _value.newUserStoryUploadSuccess
          : newUserStoryUploadSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      newUserStoryUploadFail: null == newUserStoryUploadFail
          ? _value.newUserStoryUploadFail
          : newUserStoryUploadFail // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {ViewStoryModel? uploadedStories,
      String userName,
      String userCircularAvatarUrl,
      bool isVerified,
      File? currentUploadedFile,
      bool isLoading,
      String? error,
      bool newUserStoryUploadSuccess,
      bool newUserStoryUploadFail});
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
    Object? uploadedStories = freezed,
    Object? userName = null,
    Object? userCircularAvatarUrl = null,
    Object? isVerified = null,
    Object? currentUploadedFile = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? newUserStoryUploadSuccess = null,
    Object? newUserStoryUploadFail = null,
  }) {
    return _then(_$UploadStoryStateImpl(
      uploadedStories: freezed == uploadedStories
          ? _value.uploadedStories
          : uploadedStories // ignore: cast_nullable_to_non_nullable
              as ViewStoryModel?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userCircularAvatarUrl: null == userCircularAvatarUrl
          ? _value.userCircularAvatarUrl
          : userCircularAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUploadedFile: freezed == currentUploadedFile
          ? _value.currentUploadedFile
          : currentUploadedFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      newUserStoryUploadSuccess: null == newUserStoryUploadSuccess
          ? _value.newUserStoryUploadSuccess
          : newUserStoryUploadSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      newUserStoryUploadFail: null == newUserStoryUploadFail
          ? _value.newUserStoryUploadFail
          : newUserStoryUploadFail // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UploadStoryStateImpl implements _UploadStoryState {
  const _$UploadStoryStateImpl(
      {this.uploadedStories = null,
      this.userName = "",
      this.userCircularAvatarUrl = "",
      this.isVerified = false,
      this.currentUploadedFile = null,
      this.isLoading = false,
      this.error = null,
      this.newUserStoryUploadSuccess = false,
      this.newUserStoryUploadFail = false});

// When Viewing the Stories
  @override
  @JsonKey()
  final ViewStoryModel? uploadedStories;
// When uploading the Story
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String userCircularAvatarUrl;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final File? currentUploadedFile;
// General
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String? error;
  @override
  @JsonKey()
  final bool newUserStoryUploadSuccess;
  @override
  @JsonKey()
  final bool newUserStoryUploadFail;

  @override
  String toString() {
    return 'UploadStoryState.uploadStoryState(uploadedStories: $uploadedStories, userName: $userName, userCircularAvatarUrl: $userCircularAvatarUrl, isVerified: $isVerified, currentUploadedFile: $currentUploadedFile, isLoading: $isLoading, error: $error, newUserStoryUploadSuccess: $newUserStoryUploadSuccess, newUserStoryUploadFail: $newUserStoryUploadFail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadStoryStateImpl &&
            (identical(other.uploadedStories, uploadedStories) ||
                other.uploadedStories == uploadedStories) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userCircularAvatarUrl, userCircularAvatarUrl) ||
                other.userCircularAvatarUrl == userCircularAvatarUrl) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.currentUploadedFile, currentUploadedFile) ||
                other.currentUploadedFile == currentUploadedFile) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.newUserStoryUploadSuccess,
                    newUserStoryUploadSuccess) ||
                other.newUserStoryUploadSuccess == newUserStoryUploadSuccess) &&
            (identical(other.newUserStoryUploadFail, newUserStoryUploadFail) ||
                other.newUserStoryUploadFail == newUserStoryUploadFail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      uploadedStories,
      userName,
      userCircularAvatarUrl,
      isVerified,
      currentUploadedFile,
      isLoading,
      error,
      newUserStoryUploadSuccess,
      newUserStoryUploadFail);

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
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)
        uploadStoryState,
  }) {
    return uploadStoryState(
        uploadedStories,
        userName,
        userCircularAvatarUrl,
        isVerified,
        currentUploadedFile,
        isLoading,
        error,
        newUserStoryUploadSuccess,
        newUserStoryUploadFail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)?
        uploadStoryState,
  }) {
    return uploadStoryState?.call(
        uploadedStories,
        userName,
        userCircularAvatarUrl,
        isVerified,
        currentUploadedFile,
        isLoading,
        error,
        newUserStoryUploadSuccess,
        newUserStoryUploadFail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            ViewStoryModel? uploadedStories,
            String userName,
            String userCircularAvatarUrl,
            bool isVerified,
            File? currentUploadedFile,
            bool isLoading,
            String? error,
            bool newUserStoryUploadSuccess,
            bool newUserStoryUploadFail)?
        uploadStoryState,
    required TResult orElse(),
  }) {
    if (uploadStoryState != null) {
      return uploadStoryState(
          uploadedStories,
          userName,
          userCircularAvatarUrl,
          isVerified,
          currentUploadedFile,
          isLoading,
          error,
          newUserStoryUploadSuccess,
          newUserStoryUploadFail);
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
      {final ViewStoryModel? uploadedStories,
      final String userName,
      final String userCircularAvatarUrl,
      final bool isVerified,
      final File? currentUploadedFile,
      final bool isLoading,
      final String? error,
      final bool newUserStoryUploadSuccess,
      final bool newUserStoryUploadFail}) = _$UploadStoryStateImpl;

// When Viewing the Stories
  @override
  ViewStoryModel? get uploadedStories; // When uploading the Story
  @override
  String get userName;
  @override
  String get userCircularAvatarUrl;
  @override
  bool get isVerified;
  @override
  File? get currentUploadedFile; // General
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get newUserStoryUploadSuccess;
  @override
  bool get newUserStoryUploadFail;

  /// Create a copy of UploadStoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadStoryStateImplCopyWith<_$UploadStoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
