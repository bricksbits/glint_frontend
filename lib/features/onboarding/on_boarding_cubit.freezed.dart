// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'on_boarding_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnBoardingState {
  RegisterUserRequest? get currentState => throw _privateConstructorUsedError;
  OnBoardingCompletedTill get onBoardingStatus =>
      throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  List<File?> get uploadedFilePaths => throw _privateConstructorUsedError;
  String? get currentDestination => throw _privateConstructorUsedError;
  bool? get isLocationLoading => throw _privateConstructorUsedError;
  bool? get locationPermissionDenied => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of OnBoardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnBoardingStateCopyWith<OnBoardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnBoardingStateCopyWith<$Res> {
  factory $OnBoardingStateCopyWith(
          OnBoardingState value, $Res Function(OnBoardingState) then) =
      _$OnBoardingStateCopyWithImpl<$Res, OnBoardingState>;
  @useResult
  $Res call(
      {RegisterUserRequest? currentState,
      OnBoardingCompletedTill onBoardingStatus,
      String error,
      List<File?> uploadedFilePaths,
      String? currentDestination,
      bool? isLocationLoading,
      bool? locationPermissionDenied});
}

/// @nodoc
class _$OnBoardingStateCopyWithImpl<$Res, $Val extends OnBoardingState>
    implements $OnBoardingStateCopyWith<$Res> {
  _$OnBoardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnBoardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentState = freezed,
    Object? onBoardingStatus = null,
    Object? error = null,
    Object? uploadedFilePaths = null,
    Object? currentDestination = freezed,
    Object? isLocationLoading = freezed,
    Object? locationPermissionDenied = freezed,
  }) {
    return _then(_value.copyWith(
      currentState: freezed == currentState
          ? _value.currentState
          : currentState // ignore: cast_nullable_to_non_nullable
              as RegisterUserRequest?,
      onBoardingStatus: null == onBoardingStatus
          ? _value.onBoardingStatus
          : onBoardingStatus // ignore: cast_nullable_to_non_nullable
              as OnBoardingCompletedTill,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedFilePaths: null == uploadedFilePaths
          ? _value.uploadedFilePaths
          : uploadedFilePaths // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      currentDestination: freezed == currentDestination
          ? _value.currentDestination
          : currentDestination // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocationLoading: freezed == isLocationLoading
          ? _value.isLocationLoading
          : isLocationLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      locationPermissionDenied: freezed == locationPermissionDenied
          ? _value.locationPermissionDenied
          : locationPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $OnBoardingStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RegisterUserRequest? currentState,
      OnBoardingCompletedTill onBoardingStatus,
      String error,
      List<File?> uploadedFilePaths,
      String? currentDestination,
      bool? isLocationLoading,
      bool? locationPermissionDenied});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OnBoardingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnBoardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentState = freezed,
    Object? onBoardingStatus = null,
    Object? error = null,
    Object? uploadedFilePaths = null,
    Object? currentDestination = freezed,
    Object? isLocationLoading = freezed,
    Object? locationPermissionDenied = freezed,
  }) {
    return _then(_$InitialImpl(
      currentState: freezed == currentState
          ? _value.currentState
          : currentState // ignore: cast_nullable_to_non_nullable
              as RegisterUserRequest?,
      onBoardingStatus: null == onBoardingStatus
          ? _value.onBoardingStatus
          : onBoardingStatus // ignore: cast_nullable_to_non_nullable
              as OnBoardingCompletedTill,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedFilePaths: null == uploadedFilePaths
          ? _value._uploadedFilePaths
          : uploadedFilePaths // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      currentDestination: freezed == currentDestination
          ? _value.currentDestination
          : currentDestination // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocationLoading: freezed == isLocationLoading
          ? _value.isLocationLoading
          : isLocationLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      locationPermissionDenied: freezed == locationPermissionDenied
          ? _value.locationPermissionDenied
          : locationPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.currentState = null,
      this.onBoardingStatus = OnBoardingCompletedTill.NOT_STARTED,
      this.error = "",
      final List<File?> uploadedFilePaths = const [],
      this.currentDestination = null,
      this.isLocationLoading,
      this.locationPermissionDenied})
      : _uploadedFilePaths = uploadedFilePaths;

  @override
  @JsonKey()
  final RegisterUserRequest? currentState;
  @override
  @JsonKey()
  final OnBoardingCompletedTill onBoardingStatus;
  @override
  @JsonKey()
  final String error;
  final List<File?> _uploadedFilePaths;
  @override
  @JsonKey()
  List<File?> get uploadedFilePaths {
    if (_uploadedFilePaths is EqualUnmodifiableListView)
      return _uploadedFilePaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uploadedFilePaths);
  }

  @override
  @JsonKey()
  final String? currentDestination;
  @override
  final bool? isLocationLoading;
  @override
  final bool? locationPermissionDenied;

  @override
  String toString() {
    return 'OnBoardingState.initial(currentState: $currentState, onBoardingStatus: $onBoardingStatus, error: $error, uploadedFilePaths: $uploadedFilePaths, currentDestination: $currentDestination, isLocationLoading: $isLocationLoading, locationPermissionDenied: $locationPermissionDenied)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.currentState, currentState) ||
                other.currentState == currentState) &&
            (identical(other.onBoardingStatus, onBoardingStatus) ||
                other.onBoardingStatus == onBoardingStatus) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._uploadedFilePaths, _uploadedFilePaths) &&
            (identical(other.currentDestination, currentDestination) ||
                other.currentDestination == currentDestination) &&
            (identical(other.isLocationLoading, isLocationLoading) ||
                other.isLocationLoading == isLocationLoading) &&
            (identical(
                    other.locationPermissionDenied, locationPermissionDenied) ||
                other.locationPermissionDenied == locationPermissionDenied));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentState,
      onBoardingStatus,
      error,
      const DeepCollectionEquality().hash(_uploadedFilePaths),
      currentDestination,
      isLocationLoading,
      locationPermissionDenied);

  /// Create a copy of OnBoardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)
        initial,
  }) {
    return initial(currentState, onBoardingStatus, error, uploadedFilePaths,
        currentDestination, isLocationLoading, locationPermissionDenied);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)?
        initial,
  }) {
    return initial?.call(
        currentState,
        onBoardingStatus,
        error,
        uploadedFilePaths,
        currentDestination,
        isLocationLoading,
        locationPermissionDenied);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RegisterUserRequest? currentState,
            OnBoardingCompletedTill onBoardingStatus,
            String error,
            List<File?> uploadedFilePaths,
            String? currentDestination,
            bool? isLocationLoading,
            bool? locationPermissionDenied)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(currentState, onBoardingStatus, error, uploadedFilePaths,
          currentDestination, isLocationLoading, locationPermissionDenied);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OnBoardingState {
  const factory _Initial(
      {final RegisterUserRequest? currentState,
      final OnBoardingCompletedTill onBoardingStatus,
      final String error,
      final List<File?> uploadedFilePaths,
      final String? currentDestination,
      final bool? isLocationLoading,
      final bool? locationPermissionDenied}) = _$InitialImpl;

  @override
  RegisterUserRequest? get currentState;
  @override
  OnBoardingCompletedTill get onBoardingStatus;
  @override
  String get error;
  @override
  List<File?> get uploadedFilePaths;
  @override
  String? get currentDestination;
  @override
  bool? get isLocationLoading;
  @override
  bool? get locationPermissionDenied;

  /// Create a copy of OnBoardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
