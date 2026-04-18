// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TicketHistoryState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<EventTicketHistoryDomainModel> get tickets =>
      throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of TicketHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketHistoryStateCopyWith<TicketHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketHistoryStateCopyWith<$Res> {
  factory $TicketHistoryStateCopyWith(
          TicketHistoryState value, $Res Function(TicketHistoryState) then) =
      _$TicketHistoryStateCopyWithImpl<$Res, TicketHistoryState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<EventTicketHistoryDomainModel> tickets,
      int offset,
      bool hasMore,
      String? error});
}

/// @nodoc
class _$TicketHistoryStateCopyWithImpl<$Res, $Val extends TicketHistoryState>
    implements $TicketHistoryStateCopyWith<$Res> {
  _$TicketHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? tickets = null,
    Object? offset = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      tickets: null == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<EventTicketHistoryDomainModel>,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketHistoryStateImplCopyWith<$Res>
    implements $TicketHistoryStateCopyWith<$Res> {
  factory _$$TicketHistoryStateImplCopyWith(_$TicketHistoryStateImpl value,
          $Res Function(_$TicketHistoryStateImpl) then) =
      __$$TicketHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<EventTicketHistoryDomainModel> tickets,
      int offset,
      bool hasMore,
      String? error});
}

/// @nodoc
class __$$TicketHistoryStateImplCopyWithImpl<$Res>
    extends _$TicketHistoryStateCopyWithImpl<$Res, _$TicketHistoryStateImpl>
    implements _$$TicketHistoryStateImplCopyWith<$Res> {
  __$$TicketHistoryStateImplCopyWithImpl(_$TicketHistoryStateImpl _value,
      $Res Function(_$TicketHistoryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TicketHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? tickets = null,
    Object? offset = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(_$TicketHistoryStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      tickets: null == tickets
          ? _value._tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<EventTicketHistoryDomainModel>,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TicketHistoryStateImpl implements _TicketHistoryState {
  const _$TicketHistoryStateImpl(
      {this.isLoading = false,
      this.isLoadingMore = false,
      final List<EventTicketHistoryDomainModel> tickets = const [],
      this.offset = 0,
      this.hasMore = true,
      this.error = null})
      : _tickets = tickets;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final List<EventTicketHistoryDomainModel> _tickets;
  @override
  @JsonKey()
  List<EventTicketHistoryDomainModel> get tickets {
    if (_tickets is EqualUnmodifiableListView) return _tickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tickets);
  }

  @override
  @JsonKey()
  final int offset;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final String? error;

  @override
  String toString() {
    return 'TicketHistoryState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, tickets: $tickets, offset: $offset, hasMore: $hasMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketHistoryStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality().equals(other._tickets, _tickets) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isLoadingMore,
      const DeepCollectionEquality().hash(_tickets), offset, hasMore, error);

  /// Create a copy of TicketHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketHistoryStateImplCopyWith<_$TicketHistoryStateImpl> get copyWith =>
      __$$TicketHistoryStateImplCopyWithImpl<_$TicketHistoryStateImpl>(
          this, _$identity);
}

abstract class _TicketHistoryState implements TicketHistoryState {
  const factory _TicketHistoryState(
      {final bool isLoading,
      final bool isLoadingMore,
      final List<EventTicketHistoryDomainModel> tickets,
      final int offset,
      final bool hasMore,
      final String? error}) = _$TicketHistoryStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  List<EventTicketHistoryDomainModel> get tickets;
  @override
  int get offset;
  @override
  bool get hasMore;
  @override
  String? get error;

  /// Create a copy of TicketHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketHistoryStateImplCopyWith<_$TicketHistoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
