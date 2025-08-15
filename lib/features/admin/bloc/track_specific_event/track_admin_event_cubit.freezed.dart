// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_admin_event_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TrackAdminEventState {
  int? get eventId => throw _privateConstructorUsedError;
  String get eventTitle => throw _privateConstructorUsedError;
  String get eventDate => throw _privateConstructorUsedError;
  String get eventImageUrl => throw _privateConstructorUsedError;
  String get interestedUserCount => throw _privateConstructorUsedError;
  String get revenueGenerated => throw _privateConstructorUsedError;
  List<EventTicketBoughtDomainModel> get ticketBoughtUsers =>
      throw _privateConstructorUsedError;
  List<EventInterestedUserDomainModel> get interestedUsers =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)
        trackEventState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)?
        trackEventState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)?
        trackEventState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrackEventState value) trackEventState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrackEventState value)? trackEventState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrackEventState value)? trackEventState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TrackAdminEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackAdminEventStateCopyWith<TrackAdminEventState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackAdminEventStateCopyWith<$Res> {
  factory $TrackAdminEventStateCopyWith(TrackAdminEventState value,
          $Res Function(TrackAdminEventState) then) =
      _$TrackAdminEventStateCopyWithImpl<$Res, TrackAdminEventState>;
  @useResult
  $Res call(
      {int? eventId,
      String eventTitle,
      String eventDate,
      String eventImageUrl,
      String interestedUserCount,
      String revenueGenerated,
      List<EventTicketBoughtDomainModel> ticketBoughtUsers,
      List<EventInterestedUserDomainModel> interestedUsers,
      bool isLoading,
      String error});
}

/// @nodoc
class _$TrackAdminEventStateCopyWithImpl<$Res,
        $Val extends TrackAdminEventState>
    implements $TrackAdminEventStateCopyWith<$Res> {
  _$TrackAdminEventStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackAdminEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? eventTitle = null,
    Object? eventDate = null,
    Object? eventImageUrl = null,
    Object? interestedUserCount = null,
    Object? revenueGenerated = null,
    Object? ticketBoughtUsers = null,
    Object? interestedUsers = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      eventTitle: null == eventTitle
          ? _value.eventTitle
          : eventTitle // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as String,
      eventImageUrl: null == eventImageUrl
          ? _value.eventImageUrl
          : eventImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      interestedUserCount: null == interestedUserCount
          ? _value.interestedUserCount
          : interestedUserCount // ignore: cast_nullable_to_non_nullable
              as String,
      revenueGenerated: null == revenueGenerated
          ? _value.revenueGenerated
          : revenueGenerated // ignore: cast_nullable_to_non_nullable
              as String,
      ticketBoughtUsers: null == ticketBoughtUsers
          ? _value.ticketBoughtUsers
          : ticketBoughtUsers // ignore: cast_nullable_to_non_nullable
              as List<EventTicketBoughtDomainModel>,
      interestedUsers: null == interestedUsers
          ? _value.interestedUsers
          : interestedUsers // ignore: cast_nullable_to_non_nullable
              as List<EventInterestedUserDomainModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackEventStateImplCopyWith<$Res>
    implements $TrackAdminEventStateCopyWith<$Res> {
  factory _$$TrackEventStateImplCopyWith(_$TrackEventStateImpl value,
          $Res Function(_$TrackEventStateImpl) then) =
      __$$TrackEventStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? eventId,
      String eventTitle,
      String eventDate,
      String eventImageUrl,
      String interestedUserCount,
      String revenueGenerated,
      List<EventTicketBoughtDomainModel> ticketBoughtUsers,
      List<EventInterestedUserDomainModel> interestedUsers,
      bool isLoading,
      String error});
}

/// @nodoc
class __$$TrackEventStateImplCopyWithImpl<$Res>
    extends _$TrackAdminEventStateCopyWithImpl<$Res, _$TrackEventStateImpl>
    implements _$$TrackEventStateImplCopyWith<$Res> {
  __$$TrackEventStateImplCopyWithImpl(
      _$TrackEventStateImpl _value, $Res Function(_$TrackEventStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrackAdminEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? eventTitle = null,
    Object? eventDate = null,
    Object? eventImageUrl = null,
    Object? interestedUserCount = null,
    Object? revenueGenerated = null,
    Object? ticketBoughtUsers = null,
    Object? interestedUsers = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_$TrackEventStateImpl(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      eventTitle: null == eventTitle
          ? _value.eventTitle
          : eventTitle // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as String,
      eventImageUrl: null == eventImageUrl
          ? _value.eventImageUrl
          : eventImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      interestedUserCount: null == interestedUserCount
          ? _value.interestedUserCount
          : interestedUserCount // ignore: cast_nullable_to_non_nullable
              as String,
      revenueGenerated: null == revenueGenerated
          ? _value.revenueGenerated
          : revenueGenerated // ignore: cast_nullable_to_non_nullable
              as String,
      ticketBoughtUsers: null == ticketBoughtUsers
          ? _value._ticketBoughtUsers
          : ticketBoughtUsers // ignore: cast_nullable_to_non_nullable
              as List<EventTicketBoughtDomainModel>,
      interestedUsers: null == interestedUsers
          ? _value._interestedUsers
          : interestedUsers // ignore: cast_nullable_to_non_nullable
              as List<EventInterestedUserDomainModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TrackEventStateImpl implements _TrackEventState {
  const _$TrackEventStateImpl(
      {this.eventId = null,
      this.eventTitle = "",
      this.eventDate = "",
      this.eventImageUrl = "",
      this.interestedUserCount = "0",
      this.revenueGenerated = "000",
      final List<EventTicketBoughtDomainModel> ticketBoughtUsers = const [],
      final List<EventInterestedUserDomainModel> interestedUsers = const [],
      this.isLoading = false,
      this.error = ""})
      : _ticketBoughtUsers = ticketBoughtUsers,
        _interestedUsers = interestedUsers;

  @override
  @JsonKey()
  final int? eventId;
  @override
  @JsonKey()
  final String eventTitle;
  @override
  @JsonKey()
  final String eventDate;
  @override
  @JsonKey()
  final String eventImageUrl;
  @override
  @JsonKey()
  final String interestedUserCount;
  @override
  @JsonKey()
  final String revenueGenerated;
  final List<EventTicketBoughtDomainModel> _ticketBoughtUsers;
  @override
  @JsonKey()
  List<EventTicketBoughtDomainModel> get ticketBoughtUsers {
    if (_ticketBoughtUsers is EqualUnmodifiableListView)
      return _ticketBoughtUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ticketBoughtUsers);
  }

  final List<EventInterestedUserDomainModel> _interestedUsers;
  @override
  @JsonKey()
  List<EventInterestedUserDomainModel> get interestedUsers {
    if (_interestedUsers is EqualUnmodifiableListView) return _interestedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interestedUsers);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'TrackAdminEventState.trackEventState(eventId: $eventId, eventTitle: $eventTitle, eventDate: $eventDate, eventImageUrl: $eventImageUrl, interestedUserCount: $interestedUserCount, revenueGenerated: $revenueGenerated, ticketBoughtUsers: $ticketBoughtUsers, interestedUsers: $interestedUsers, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackEventStateImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.eventTitle, eventTitle) ||
                other.eventTitle == eventTitle) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.eventImageUrl, eventImageUrl) ||
                other.eventImageUrl == eventImageUrl) &&
            (identical(other.interestedUserCount, interestedUserCount) ||
                other.interestedUserCount == interestedUserCount) &&
            (identical(other.revenueGenerated, revenueGenerated) ||
                other.revenueGenerated == revenueGenerated) &&
            const DeepCollectionEquality()
                .equals(other._ticketBoughtUsers, _ticketBoughtUsers) &&
            const DeepCollectionEquality()
                .equals(other._interestedUsers, _interestedUsers) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      eventTitle,
      eventDate,
      eventImageUrl,
      interestedUserCount,
      revenueGenerated,
      const DeepCollectionEquality().hash(_ticketBoughtUsers),
      const DeepCollectionEquality().hash(_interestedUsers),
      isLoading,
      error);

  /// Create a copy of TrackAdminEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackEventStateImplCopyWith<_$TrackEventStateImpl> get copyWith =>
      __$$TrackEventStateImplCopyWithImpl<_$TrackEventStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)
        trackEventState,
  }) {
    return trackEventState(
        eventId,
        eventTitle,
        eventDate,
        eventImageUrl,
        interestedUserCount,
        revenueGenerated,
        ticketBoughtUsers,
        interestedUsers,
        isLoading,
        error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)?
        trackEventState,
  }) {
    return trackEventState?.call(
        eventId,
        eventTitle,
        eventDate,
        eventImageUrl,
        interestedUserCount,
        revenueGenerated,
        ticketBoughtUsers,
        interestedUsers,
        isLoading,
        error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? eventId,
            String eventTitle,
            String eventDate,
            String eventImageUrl,
            String interestedUserCount,
            String revenueGenerated,
            List<EventTicketBoughtDomainModel> ticketBoughtUsers,
            List<EventInterestedUserDomainModel> interestedUsers,
            bool isLoading,
            String error)?
        trackEventState,
    required TResult orElse(),
  }) {
    if (trackEventState != null) {
      return trackEventState(
          eventId,
          eventTitle,
          eventDate,
          eventImageUrl,
          interestedUserCount,
          revenueGenerated,
          ticketBoughtUsers,
          interestedUsers,
          isLoading,
          error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrackEventState value) trackEventState,
  }) {
    return trackEventState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrackEventState value)? trackEventState,
  }) {
    return trackEventState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrackEventState value)? trackEventState,
    required TResult orElse(),
  }) {
    if (trackEventState != null) {
      return trackEventState(this);
    }
    return orElse();
  }
}

abstract class _TrackEventState implements TrackAdminEventState {
  const factory _TrackEventState(
      {final int? eventId,
      final String eventTitle,
      final String eventDate,
      final String eventImageUrl,
      final String interestedUserCount,
      final String revenueGenerated,
      final List<EventTicketBoughtDomainModel> ticketBoughtUsers,
      final List<EventInterestedUserDomainModel> interestedUsers,
      final bool isLoading,
      final String error}) = _$TrackEventStateImpl;

  @override
  int? get eventId;
  @override
  String get eventTitle;
  @override
  String get eventDate;
  @override
  String get eventImageUrl;
  @override
  String get interestedUserCount;
  @override
  String get revenueGenerated;
  @override
  List<EventTicketBoughtDomainModel> get ticketBoughtUsers;
  @override
  List<EventInterestedUserDomainModel> get interestedUsers;
  @override
  bool get isLoading;
  @override
  String get error;

  /// Create a copy of TrackAdminEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackEventStateImplCopyWith<_$TrackEventStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
