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
    required TResult Function(String id) trackEventWithId,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? trackEventWithId,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? trackEventWithId,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_TrackEventWithId value) trackEventWithId,
    required TResult Function(_EmitNewState value) emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_TrackEventWithId value)? trackEventWithId,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_TrackEventWithId value)? trackEventWithId,
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
    required TResult Function(String id) trackEventWithId,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? trackEventWithId,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? trackEventWithId,
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
    required TResult Function(_TrackEventWithId value) trackEventWithId,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_TrackEventWithId value)? trackEventWithId,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_TrackEventWithId value)? trackEventWithId,
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
abstract class _$$TrackEventWithIdImplCopyWith<$Res> {
  factory _$$TrackEventWithIdImplCopyWith(_$TrackEventWithIdImpl value,
          $Res Function(_$TrackEventWithIdImpl) then) =
      __$$TrackEventWithIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$TrackEventWithIdImplCopyWithImpl<$Res>
    extends _$AdminDashboardEventCopyWithImpl<$Res, _$TrackEventWithIdImpl>
    implements _$$TrackEventWithIdImplCopyWith<$Res> {
  __$$TrackEventWithIdImplCopyWithImpl(_$TrackEventWithIdImpl _value,
      $Res Function(_$TrackEventWithIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$TrackEventWithIdImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TrackEventWithIdImpl implements _TrackEventWithId {
  const _$TrackEventWithIdImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'AdminDashboardEvent.trackEventWithId(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackEventWithIdImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackEventWithIdImplCopyWith<_$TrackEventWithIdImpl> get copyWith =>
      __$$TrackEventWithIdImplCopyWithImpl<_$TrackEventWithIdImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String id) trackEventWithId,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return trackEventWithId(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? trackEventWithId,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return trackEventWithId?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? trackEventWithId,
    TResult Function(AdminDashboardState newState)? emitNewState,
    required TResult orElse(),
  }) {
    if (trackEventWithId != null) {
      return trackEventWithId(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_TrackEventWithId value) trackEventWithId,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return trackEventWithId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_TrackEventWithId value)? trackEventWithId,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return trackEventWithId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_TrackEventWithId value)? trackEventWithId,
    TResult Function(_EmitNewState value)? emitNewState,
    required TResult orElse(),
  }) {
    if (trackEventWithId != null) {
      return trackEventWithId(this);
    }
    return orElse();
  }
}

abstract class _TrackEventWithId implements AdminDashboardEvent {
  const factory _TrackEventWithId(final String id) = _$TrackEventWithIdImpl;

  String get id;

  /// Create a copy of AdminDashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackEventWithIdImplCopyWith<_$TrackEventWithIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    required TResult Function(String id) trackEventWithId,
    required TResult Function(AdminDashboardState newState) emitNewState,
  }) {
    return emitNewState(newState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String id)? trackEventWithId,
    TResult? Function(AdminDashboardState newState)? emitNewState,
  }) {
    return emitNewState?.call(newState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String id)? trackEventWithId,
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
    required TResult Function(_TrackEventWithId value) trackEventWithId,
    required TResult Function(_EmitNewState value) emitNewState,
  }) {
    return emitNewState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_TrackEventWithId value)? trackEventWithId,
    TResult? Function(_EmitNewState value)? emitNewState,
  }) {
    return emitNewState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_TrackEventWithId value)? trackEventWithId,
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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error)?
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
      String error});
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
      String error});
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
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.isLoading = true,
      final List<AdminEventListDomainModel> recentEvents = const [],
      final List<AdminEventListDomainModel> allPublishedEvents = const [],
      this.error = ""})
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
  String toString() {
    return 'AdminDashboardState.initial(isLoading: $isLoading, recentEvents: $recentEvents, allPublishedEvents: $allPublishedEvents, error: $error)';
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
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_recentEvents),
      const DeepCollectionEquality().hash(_allPublishedEvents),
      error);

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
            String error)
        initial,
  }) {
    return initial(isLoading, recentEvents, allPublishedEvents, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error)?
        initial,
  }) {
    return initial?.call(isLoading, recentEvents, allPublishedEvents, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<AdminEventListDomainModel> recentEvents,
            List<AdminEventListDomainModel> allPublishedEvents,
            String error)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(isLoading, recentEvents, allPublishedEvents, error);
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
      final String error}) = _$InitialImpl;

  @override
  bool get isLoading;
  @override
  List<AdminEventListDomainModel> get recentEvents;
  @override
  List<AdminEventListDomainModel> get allPublishedEvents;
  @override
  String get error;

  /// Create a copy of AdminDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
