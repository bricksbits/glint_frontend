// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentHistoryState {
  List<PaymentHistoryModel> get completeHistory =>
      throw _privateConstructorUsedError;
  List<PaymentHistoryModel> get eventHistory =>
      throw _privateConstructorUsedError;
  List<PaymentHistoryModel> get membershipHistory =>
      throw _privateConstructorUsedError;
  List<PaymentHistoryModel> get currentSelectedList =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  PaymentHistoryEnums get currentSelectedChip =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)?
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

  /// Create a copy of PaymentHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentHistoryStateCopyWith<PaymentHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryStateCopyWith<$Res> {
  factory $PaymentHistoryStateCopyWith(
          PaymentHistoryState value, $Res Function(PaymentHistoryState) then) =
      _$PaymentHistoryStateCopyWithImpl<$Res, PaymentHistoryState>;
  @useResult
  $Res call(
      {List<PaymentHistoryModel> completeHistory,
      List<PaymentHistoryModel> eventHistory,
      List<PaymentHistoryModel> membershipHistory,
      List<PaymentHistoryModel> currentSelectedList,
      bool isLoading,
      String error,
      PaymentHistoryEnums currentSelectedChip});
}

/// @nodoc
class _$PaymentHistoryStateCopyWithImpl<$Res, $Val extends PaymentHistoryState>
    implements $PaymentHistoryStateCopyWith<$Res> {
  _$PaymentHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completeHistory = null,
    Object? eventHistory = null,
    Object? membershipHistory = null,
    Object? currentSelectedList = null,
    Object? isLoading = null,
    Object? error = null,
    Object? currentSelectedChip = null,
  }) {
    return _then(_value.copyWith(
      completeHistory: null == completeHistory
          ? _value.completeHistory
          : completeHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      eventHistory: null == eventHistory
          ? _value.eventHistory
          : eventHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      membershipHistory: null == membershipHistory
          ? _value.membershipHistory
          : membershipHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      currentSelectedList: null == currentSelectedList
          ? _value.currentSelectedList
          : currentSelectedList // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      currentSelectedChip: null == currentSelectedChip
          ? _value.currentSelectedChip
          : currentSelectedChip // ignore: cast_nullable_to_non_nullable
              as PaymentHistoryEnums,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $PaymentHistoryStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PaymentHistoryModel> completeHistory,
      List<PaymentHistoryModel> eventHistory,
      List<PaymentHistoryModel> membershipHistory,
      List<PaymentHistoryModel> currentSelectedList,
      bool isLoading,
      String error,
      PaymentHistoryEnums currentSelectedChip});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PaymentHistoryStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completeHistory = null,
    Object? eventHistory = null,
    Object? membershipHistory = null,
    Object? currentSelectedList = null,
    Object? isLoading = null,
    Object? error = null,
    Object? currentSelectedChip = null,
  }) {
    return _then(_$InitialImpl(
      completeHistory: null == completeHistory
          ? _value._completeHistory
          : completeHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      eventHistory: null == eventHistory
          ? _value._eventHistory
          : eventHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      membershipHistory: null == membershipHistory
          ? _value._membershipHistory
          : membershipHistory // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      currentSelectedList: null == currentSelectedList
          ? _value._currentSelectedList
          : currentSelectedList // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistoryModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      currentSelectedChip: null == currentSelectedChip
          ? _value.currentSelectedChip
          : currentSelectedChip // ignore: cast_nullable_to_non_nullable
              as PaymentHistoryEnums,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {final List<PaymentHistoryModel> completeHistory = const [],
      final List<PaymentHistoryModel> eventHistory = const [],
      final List<PaymentHistoryModel> membershipHistory = const [],
      final List<PaymentHistoryModel> currentSelectedList = const [],
      this.isLoading = false,
      this.error = "",
      this.currentSelectedChip = PaymentHistoryEnums.ALL})
      : _completeHistory = completeHistory,
        _eventHistory = eventHistory,
        _membershipHistory = membershipHistory,
        _currentSelectedList = currentSelectedList;

  final List<PaymentHistoryModel> _completeHistory;
  @override
  @JsonKey()
  List<PaymentHistoryModel> get completeHistory {
    if (_completeHistory is EqualUnmodifiableListView) return _completeHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completeHistory);
  }

  final List<PaymentHistoryModel> _eventHistory;
  @override
  @JsonKey()
  List<PaymentHistoryModel> get eventHistory {
    if (_eventHistory is EqualUnmodifiableListView) return _eventHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eventHistory);
  }

  final List<PaymentHistoryModel> _membershipHistory;
  @override
  @JsonKey()
  List<PaymentHistoryModel> get membershipHistory {
    if (_membershipHistory is EqualUnmodifiableListView)
      return _membershipHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_membershipHistory);
  }

  final List<PaymentHistoryModel> _currentSelectedList;
  @override
  @JsonKey()
  List<PaymentHistoryModel> get currentSelectedList {
    if (_currentSelectedList is EqualUnmodifiableListView)
      return _currentSelectedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentSelectedList);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final PaymentHistoryEnums currentSelectedChip;

  @override
  String toString() {
    return 'PaymentHistoryState.initial(completeHistory: $completeHistory, eventHistory: $eventHistory, membershipHistory: $membershipHistory, currentSelectedList: $currentSelectedList, isLoading: $isLoading, error: $error, currentSelectedChip: $currentSelectedChip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality()
                .equals(other._completeHistory, _completeHistory) &&
            const DeepCollectionEquality()
                .equals(other._eventHistory, _eventHistory) &&
            const DeepCollectionEquality()
                .equals(other._membershipHistory, _membershipHistory) &&
            const DeepCollectionEquality()
                .equals(other._currentSelectedList, _currentSelectedList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentSelectedChip, currentSelectedChip) ||
                other.currentSelectedChip == currentSelectedChip));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_completeHistory),
      const DeepCollectionEquality().hash(_eventHistory),
      const DeepCollectionEquality().hash(_membershipHistory),
      const DeepCollectionEquality().hash(_currentSelectedList),
      isLoading,
      error,
      currentSelectedChip);

  /// Create a copy of PaymentHistoryState
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
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)
        initial,
  }) {
    return initial(completeHistory, eventHistory, membershipHistory,
        currentSelectedList, isLoading, error, currentSelectedChip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)?
        initial,
  }) {
    return initial?.call(completeHistory, eventHistory, membershipHistory,
        currentSelectedList, isLoading, error, currentSelectedChip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<PaymentHistoryModel> completeHistory,
            List<PaymentHistoryModel> eventHistory,
            List<PaymentHistoryModel> membershipHistory,
            List<PaymentHistoryModel> currentSelectedList,
            bool isLoading,
            String error,
            PaymentHistoryEnums currentSelectedChip)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(completeHistory, eventHistory, membershipHistory,
          currentSelectedList, isLoading, error, currentSelectedChip);
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

abstract class _Initial implements PaymentHistoryState {
  const factory _Initial(
      {final List<PaymentHistoryModel> completeHistory,
      final List<PaymentHistoryModel> eventHistory,
      final List<PaymentHistoryModel> membershipHistory,
      final List<PaymentHistoryModel> currentSelectedList,
      final bool isLoading,
      final String error,
      final PaymentHistoryEnums currentSelectedChip}) = _$InitialImpl;

  @override
  List<PaymentHistoryModel> get completeHistory;
  @override
  List<PaymentHistoryModel> get eventHistory;
  @override
  List<PaymentHistoryModel> get membershipHistory;
  @override
  List<PaymentHistoryModel> get currentSelectedList;
  @override
  bool get isLoading;
  @override
  String get error;
  @override
  PaymentHistoryEnums get currentSelectedChip;

  /// Create a copy of PaymentHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
