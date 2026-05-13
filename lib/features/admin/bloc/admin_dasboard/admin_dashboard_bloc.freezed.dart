// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdminDashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDashboardEventCopyWith<$Res> {
  factory $AdminDashboardEventCopyWith(
          AdminDashboardEvent value, $Res Function(AdminDashboardEvent) then) =
      _$AdminDashboardEventCopyWithImpl<$Res, AdminDashboardEvent>;
}

/// @nodoc
class _$AdminDashboardEventCopyWithImpl<$Res, $Val extends AdminDashboardEvent>
    implements $AdminDashboardEventCopyWith<$Res> {
  _$AdminDashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDashboardEvent
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
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'AdminDashboardEvent.started()';
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
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
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
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AdminDashboardEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$FetchAdminProfileImplCopyWith<$Res> {
  factory _$$FetchAdminProfileImplCopyWith(_$FetchAdminProfileImpl value,
          $Res Function(_$FetchAdminProfileImpl) then) =
      __$$FetchAdminProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchAdminProfileImplCopyWithImpl<$Res>
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$FetchAdminProfileImpl>
    implements _$$FetchAdminProfileImplCopyWith<$Res> {
  __$$FetchAdminProfileImplCopyWithImpl(_$FetchAdminProfileImpl _value,
      $Res Function(_$FetchAdminProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchAdminProfileImpl implements _FetchAdminProfile {
  const _$FetchAdminProfileImpl();

  @override
  String toString() {
    return 'AdminDashboardEvent.fetchAdminProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchAdminProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return fetchAdminProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return fetchAdminProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) {
    if (fetchAdminProfile != null) {
      return fetchAdminProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return fetchAdminProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return fetchAdminProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (fetchAdminProfile != null) {
      return fetchAdminProfile(this);
    }
    return orElse();
  }
}

abstract class _FetchAdminProfile implements AdminDashboardEvent {
  const factory _FetchAdminProfile() = _$FetchAdminProfileImpl;
}

/// @nodoc
abstract class _$$SaveAdminProfileImplCopyWith<$Res> {
  factory _$$SaveAdminProfileImplCopyWith(_$SaveAdminProfileImpl value,
          $Res Function(_$SaveAdminProfileImpl) then) =
      __$$SaveAdminProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, String organization});
}

/// @nodoc
class __$$SaveAdminProfileImplCopyWithImpl<$Res>
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$SaveAdminProfileImpl>
    implements _$$SaveAdminProfileImplCopyWith<$Res> {
  __$$SaveAdminProfileImplCopyWithImpl(_$SaveAdminProfileImpl _value,
      $Res Function(_$SaveAdminProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? organization = null,
  }) {
    return _then(_$SaveAdminProfileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organization: null == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SaveAdminProfileImpl implements _SaveAdminProfile {
  const _$SaveAdminProfileImpl(
      {required this.name, required this.organization});

  @override
  final String name;
  @override
  final String organization;

  @override
  String toString() {
    return 'AdminDashboardEvent.saveAdminProfile(name: $name, organization: $organization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveAdminProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.organization, organization) ||
                other.organization == organization));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, organization);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveAdminProfileImplCopyWith<_$SaveAdminProfileImpl> get copyWith =>
      __$$SaveAdminProfileImplCopyWithImpl<_$SaveAdminProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return saveAdminProfile(name, organization);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return saveAdminProfile?.call(name, organization);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) {
    if (saveAdminProfile != null) {
      return saveAdminProfile(name, organization);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return saveAdminProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return saveAdminProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (saveAdminProfile != null) {
      return saveAdminProfile(this);
    }
    return orElse();
  }
}

abstract class _SaveAdminProfile implements AdminDashboardEvent {
  const factory _SaveAdminProfile(
      {required final String name,
      required final String organization}) = _$SaveAdminProfileImpl;

  String get name;
  String get organization;

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveAdminProfileImplCopyWith<_$SaveAdminProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetSaveStatusImplCopyWith<$Res> {
  factory _$$ResetSaveStatusImplCopyWith(_$ResetSaveStatusImpl value,
          $Res Function(_$ResetSaveStatusImpl) then) =
      __$$ResetSaveStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetSaveStatusImplCopyWithImpl<$Res>
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$ResetSaveStatusImpl>
    implements _$$ResetSaveStatusImplCopyWith<$Res> {
  __$$ResetSaveStatusImplCopyWithImpl(
      _$ResetSaveStatusImpl _value, $Res Function(_$ResetSaveStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetSaveStatusImpl implements _ResetSaveStatus {
  const _$ResetSaveStatusImpl();

  @override
  String toString() {
    return 'AdminDashboardEvent.resetSaveStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetSaveStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return resetSaveStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return resetSaveStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) {
    if (resetSaveStatus != null) {
      return resetSaveStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return resetSaveStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return resetSaveStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (resetSaveStatus != null) {
      return resetSaveStatus(this);
    }
    return orElse();
  }
}

abstract class _ResetSaveStatus implements AdminDashboardEvent {
  const factory _ResetSaveStatus() = _$ResetSaveStatusImpl;
}

/// @nodoc
abstract class _$$EmitNewStateImplCopyWith<$Res> {
  factory _$$EmitNewStateImplCopyWith(
          _$EmitNewStateImpl value, $Res Function(_$EmitNewStateImpl) then) =
      __$$EmitNewStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AdminDashboardState newState});

  $AdminDashboardStateCopyWith<$Res> get newState;
}

/// @nodoc
class __$$EmitNewStateImplCopyWithImpl<$Res>
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$EmitNewStateImpl>
    implements _$$EmitNewStateImplCopyWith<$Res> {
  __$$EmitNewStateImplCopyWithImpl(
      _$EmitNewStateImpl _value, $Res Function(_$EmitNewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newState = null,
  }) {
    return _then(_$EmitNewStateImpl(
      null == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as AdminDashboardState,
    ));
  }

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminDashboardStateCopyWith<$Res> get newState {
    return $AdminDashboardStateCopyWith<$Res>(_value.newState, (value) {
      return _then(_value.copyWith(newState: value));
    });
  }
}

/// @nodoc

class _$EmitNewStateImpl implements _EmitNewState {
  const _$EmitNewStateImpl(this.newState);

  @override
  final AdminDashboardState newState;

  @override
  String toString() {
    return 'AdminDashboardEvent.emitNewState(newState: $newState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmitNewStateImpl &&
            (identical(other.newState, newState) ||
                other.newState == newState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newState);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmitNewStateImplCopyWith<_$EmitNewStateImpl> get copyWith =>
      __$$EmitNewStateImplCopyWithImpl<_$EmitNewStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchAdminProfile,
    required TResult Function(String name, String organization)
        saveAdminProfile,
    required TResult Function() resetSaveStatus,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return emitNewState(newState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchAdminProfile,
    TResult? Function(String name, String organization)? saveAdminProfile,
    TResult? Function()? resetSaveStatus,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return emitNewState?.call(newState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchAdminProfile,
    TResult Function(String name, String organization)? saveAdminProfile,
    TResult Function()? resetSaveStatus,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) {
    if (emitNewState != null) {
      return emitNewState(newState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchAdminProfile value) fetchAdminProfile,
    required TResult Function(_SaveAdminProfile value) saveAdminProfile,
    required TResult Function(_ResetSaveStatus value) resetSaveStatus,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return emitNewState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult? Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult? Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return emitNewState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchAdminProfile value)? fetchAdminProfile,
    TResult Function(_SaveAdminProfile value)? saveAdminProfile,
    TResult Function(_ResetSaveStatus value)? resetSaveStatus,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (emitNewState != null) {
      return emitNewState(this);
    }
    return orElse();
  }
}

abstract class _EmitNewState implements AdminDashboardEvent {
  const factory _EmitNewState(final AdminDashboardState newState) =
      _$EmitNewStateImpl;

  AdminDashboardState get newState;

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmitNewStateImplCopyWith<_$EmitNewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdminDashboardState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<AdminEventListDomainModel> get recentEvents =>
      throw _privateConstructorUsedError;
  List<AdminEventListDomainModel> get allPublishedEvents =>
      throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get adminUserName => throw _privateConstructorUsedError;
  String get adminOrganization => throw _privateConstructorUsedError;
  PeopleCardModel? get currentUser => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isSaveSuccess => throw _privateConstructorUsedError;
  bool get isSaveError => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)?
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

  /// Create a copy of AdminDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDashboardStateCopyWith<AdminDashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardStateCopyWith(
          AdminDashboardState value, $Res Function(AdminDashboardState) then) =
      _$AdminDashboardStateCopyWithImpl<$Res, AdminDashboardState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<AdminEventListDomainModel> recentEvents,
      List<AdminEventListDomainModel> allPublishedEvents,
      String error,
      String adminUserName,
      String adminOrganization,
      PeopleCardModel? currentUser,
      bool isSaving,
      bool isSaveSuccess,
      bool isSaveError});
}

/// @nodoc
class _$AdminDashboardStateCopyWithImpl<$Res, $Val extends AdminDashboardState>
    implements $AdminDashboardStateCopyWith<$Res> {
  _$AdminDashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recentEvents = null,
    Object? allPublishedEvents = null,
    Object? error = null,
    Object? adminUserName = null,
    Object? adminOrganization = null,
    Object? currentUser = freezed,
    Object? isSaving = null,
    Object? isSaveSuccess = null,
    Object? isSaveError = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recentEvents: null == recentEvents
          ? _value.recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<AdminEventListDomainModel>,
      allPublishedEvents: null == allPublishedEvents
          ? _value.allPublishedEvents
          : allPublishedEvents // ignore: cast_nullable_to_non_nullable
              as List<AdminEventListDomainModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      adminUserName: null == adminUserName
          ? _value.adminUserName
          : adminUserName // ignore: cast_nullable_to_non_nullable
              as String,
      adminOrganization: null == adminOrganization
          ? _value.adminOrganization
          : adminOrganization // ignore: cast_nullable_to_non_nullable
              as String,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveSuccess: null == isSaveSuccess
          ? _value.isSaveSuccess
          : isSaveSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveError: null == isSaveError
          ? _value.isSaveError
          : isSaveError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $AdminDashboardStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<AdminEventListDomainModel> recentEvents,
      List<AdminEventListDomainModel> allPublishedEvents,
      String error,
      String adminUserName,
      String adminOrganization,
      PeopleCardModel? currentUser,
      bool isSaving,
      bool isSaveSuccess,
      bool isSaveError});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AdminDashboardStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recentEvents = null,
    Object? allPublishedEvents = null,
    Object? error = null,
    Object? adminUserName = null,
    Object? adminOrganization = null,
    Object? currentUser = freezed,
    Object? isSaving = null,
    Object? isSaveSuccess = null,
    Object? isSaveError = null,
  }) {
    return _then(_$InitialImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recentEvents: null == recentEvents
          ? _value._recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<AdminEventListDomainModel>,
      allPublishedEvents: null == allPublishedEvents
          ? _value._allPublishedEvents
          : allPublishedEvents // ignore: cast_nullable_to_non_nullable
              as List<AdminEventListDomainModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      adminUserName: null == adminUserName
          ? _value.adminUserName
          : adminUserName // ignore: cast_nullable_to_non_nullable
              as String,
      adminOrganization: null == adminOrganization
          ? _value.adminOrganization
          : adminOrganization // ignore: cast_nullable_to_non_nullable
              as String,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveSuccess: null == isSaveSuccess
          ? _value.isSaveSuccess
          : isSaveSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaveError: null == isSaveError
          ? _value.isSaveError
          : isSaveError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.isLoading = true,
      final List<AdminEventListDomainModel> recentEvents = const [],
      final List<AdminEventListDomainModel> allPublishedEvents = const [],
      this.error = "",
      this.adminUserName = "Event Manager",
      this.adminOrganization = "For Organization",
      this.currentUser = null,
      this.isSaving = false,
      this.isSaveSuccess = false,
      this.isSaveError = false})
      : _recentEvents = recentEvents,
        _allPublishedEvents = allPublishedEvents;

  @override
  @JsonKey()
  final bool isLoading;
  final List<AdminEventListDomainModel> _recentEvents;
  @override
  @JsonKey()
  List<AdminEventListDomainModel> get recentEvents {
    if (_recentEvents is EqualUnmodifiableListView) return _recentEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentEvents);
  }

  final List<AdminEventListDomainModel> _allPublishedEvents;
  @override
  @JsonKey()
  List<AdminEventListDomainModel> get allPublishedEvents {
    if (_allPublishedEvents is EqualUnmodifiableListView)
      return _allPublishedEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPublishedEvents);
  }

  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final String adminUserName;
  @override
  @JsonKey()
  final String adminOrganization;
  @override
  @JsonKey()
  final PeopleCardModel? currentUser;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isSaveSuccess;
  @override
  @JsonKey()
  final bool isSaveError;

  @override
  String toString() {
    return 'AdminDashboardState.initial(isLoading: $isLoading, recentEvents: $recentEvents, allPublishedEvents: $allPublishedEvents, error: $error, adminUserName: $adminUserName, adminOrganization: $adminOrganization, currentUser: $currentUser, isSaving: $isSaving, isSaveSuccess: $isSaveSuccess, isSaveError: $isSaveError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._recentEvents, _recentEvents) &&
            const DeepCollectionEquality()
                .equals(other._allPublishedEvents, _allPublishedEvents) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.adminUserName, adminUserName) ||
                other.adminUserName == adminUserName) &&
            (identical(other.adminOrganization, adminOrganization) ||
                other.adminOrganization == adminOrganization) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isSaveSuccess, isSaveSuccess) ||
                other.isSaveSuccess == isSaveSuccess) &&
            (identical(other.isSaveError, isSaveError) ||
                other.isSaveError == isSaveError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_recentEvents),
      const DeepCollectionEquality().hash(_allPublishedEvents),
      error,
      adminUserName,
      adminOrganization,
      currentUser,
      isSaving,
      isSaveSuccess,
      isSaveError);

  /// Create a copy of AdminDashboardState
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
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)
        initial,
  }) {
    return initial(
        isLoading,
        recentEvents,
        allPublishedEvents,
        error,
        adminUserName,
        adminOrganization,
        currentUser,
        isSaving,
        isSaveSuccess,
        isSaveError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)?
        initial,
  }) {
    return initial?.call(
        isLoading,
        recentEvents,
        allPublishedEvents,
        error,
        adminUserName,
        adminOrganization,
        currentUser,
        isSaving,
        isSaveSuccess,
        isSaveError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error,
            String adminUserName,
            String adminOrganization,
            PeopleCardModel? currentUser,
            bool isSaving,
            bool isSaveSuccess,
            bool isSaveError)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
          isLoading,
          recentEvents,
          allPublishedEvents,
          error,
          adminUserName,
          adminOrganization,
          currentUser,
          isSaving,
          isSaveSuccess,
          isSaveError);
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

abstract class _Initial implements AdminDashboardState {
  const factory _Initial(
      {final bool isLoading,
      final List<AdminEventListDomainModel> recentEvents,
      final List<AdminEventListDomainModel> allPublishedEvents,
      final String error,
      final String adminUserName,
      final String adminOrganization,
      final PeopleCardModel? currentUser,
      final bool isSaving,
      final bool isSaveSuccess,
      final bool isSaveError}) = _$InitialImpl;

  @override
  bool get isLoading;
  @override
  List<AdminEventListDomainModel> get recentEvents;
  @override
  List<AdminEventListDomainModel> get allPublishedEvents;
  @override
  String get error;
  @override
  String get adminUserName;
  @override
  String get adminOrganization;
  @override
  PeopleCardModel? get currentUser;
  @override
  bool get isSaving;
  @override
  bool get isSaveSuccess;
  @override
  bool get isSaveError;

  /// Create a copy of AdminDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
