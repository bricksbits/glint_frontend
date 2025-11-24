// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_manager_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserInfoManagerState {
  String? get fcmToken => throw _privateConstructorUsedError;
  ProfileMembershipEntity? get membershipEntity =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)?
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

  /// Create a copy of UserInfoManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoManagerStateCopyWith<UserInfoManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoManagerStateCopyWith<$Res> {
  factory $UserInfoManagerStateCopyWith(UserInfoManagerState value,
          $Res Function(UserInfoManagerState) then) =
      _$UserInfoManagerStateCopyWithImpl<$Res, UserInfoManagerState>;
  @useResult
  $Res call(
      {String? fcmToken,
      ProfileMembershipEntity? membershipEntity,
      String? error});
}

/// @nodoc
class _$UserInfoManagerStateCopyWithImpl<$Res,
        $Val extends UserInfoManagerState>
    implements $UserInfoManagerStateCopyWith<$Res> {
  _$UserInfoManagerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = freezed,
    Object? membershipEntity = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipEntity: freezed == membershipEntity
          ? _value.membershipEntity
          : membershipEntity // ignore: cast_nullable_to_non_nullable
              as ProfileMembershipEntity?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $UserInfoManagerStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? fcmToken,
      ProfileMembershipEntity? membershipEntity,
      String? error});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserInfoManagerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfoManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = freezed,
    Object? membershipEntity = freezed,
    Object? error = freezed,
  }) {
    return _then(_$InitialImpl(
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipEntity: freezed == membershipEntity
          ? _value.membershipEntity
          : membershipEntity // ignore: cast_nullable_to_non_nullable
              as ProfileMembershipEntity?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.fcmToken = null, this.membershipEntity = null, this.error = null});

  @override
  @JsonKey()
  final String? fcmToken;
  @override
  @JsonKey()
  final ProfileMembershipEntity? membershipEntity;
  @override
  @JsonKey()
  final String? error;

  @override
  String toString() {
    return 'UserInfoManagerState.initial(fcmToken: $fcmToken, membershipEntity: $membershipEntity, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.membershipEntity, membershipEntity) ||
                other.membershipEntity == membershipEntity) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fcmToken, membershipEntity, error);

  /// Create a copy of UserInfoManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)
        initial,
  }) {
    return initial(fcmToken, membershipEntity, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)?
        initial,
  }) {
    return initial?.call(fcmToken, membershipEntity, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fcmToken,
            ProfileMembershipEntity? membershipEntity, String? error)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(fcmToken, membershipEntity, error);
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

abstract class _Initial implements UserInfoManagerState {
  const factory _Initial(
      {final String? fcmToken,
      final ProfileMembershipEntity? membershipEntity,
      final String? error}) = _$InitialImpl;

  @override
  String? get fcmToken;
  @override
  ProfileMembershipEntity? get membershipEntity;
  @override
  String? get error;

  /// Create a copy of UserInfoManagerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
