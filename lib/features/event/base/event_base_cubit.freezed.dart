// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_base_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventBaseState {
  int? get selectedEventId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<PeopleCardModel> get selectedEventPeople =>
      throw _privateConstructorUsedError;
  List<EventListDomainModel> get allEvents =>
      throw _privateConstructorUsedError;
  List<EventListDomainModel> get hotEvents =>
      throw _privateConstructorUsedError;
  List<EventListDomainModel> get normalEvents =>
      throw _privateConstructorUsedError;
  String get categorySelected => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
            String error)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
            String error)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
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

  /// Create a copy of EventBaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventBaseStateCopyWith<EventBaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventBaseStateCopyWith<$Res> {
  factory $EventBaseStateCopyWith(
          EventBaseState value, $Res Function(EventBaseState) then) =
      _$EventBaseStateCopyWithImpl<$Res, EventBaseState>;
  @useResult
  $Res call(
      {int? selectedEventId,
      bool isLoading,
      List<PeopleCardModel> selectedEventPeople,
      List<EventListDomainModel> allEvents,
      List<EventListDomainModel> hotEvents,
      List<EventListDomainModel> normalEvents,
      String categorySelected,
      String error});
}

/// @nodoc
class _$EventBaseStateCopyWithImpl<$Res, $Val extends EventBaseState>
    implements $EventBaseStateCopyWith<$Res> {
  _$EventBaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventBaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedEventId = freezed,
    Object? isLoading = null,
    Object? selectedEventPeople = null,
    Object? allEvents = null,
    Object? hotEvents = null,
    Object? normalEvents = null,
    Object? categorySelected = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      selectedEventId: freezed == selectedEventId
          ? _value.selectedEventId
          : selectedEventId // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedEventPeople: null == selectedEventPeople
          ? _value.selectedEventPeople
          : selectedEventPeople // ignore: cast_nullable_to_non_nullable
              as List<PeopleCardModel>,
      allEvents: null == allEvents
          ? _value.allEvents
          : allEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      hotEvents: null == hotEvents
          ? _value.hotEvents
          : hotEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      normalEvents: null == normalEvents
          ? _value.normalEvents
          : normalEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $EventBaseStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? selectedEventId,
      bool isLoading,
      List<PeopleCardModel> selectedEventPeople,
      List<EventListDomainModel> allEvents,
      List<EventListDomainModel> hotEvents,
      List<EventListDomainModel> normalEvents,
      String categorySelected,
      String error});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$EventBaseStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventBaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedEventId = freezed,
    Object? isLoading = null,
    Object? selectedEventPeople = null,
    Object? allEvents = null,
    Object? hotEvents = null,
    Object? normalEvents = null,
    Object? categorySelected = null,
    Object? error = null,
  }) {
    return _then(_$InitialImpl(
      selectedEventId: freezed == selectedEventId
          ? _value.selectedEventId
          : selectedEventId // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedEventPeople: null == selectedEventPeople
          ? _value._selectedEventPeople
          : selectedEventPeople // ignore: cast_nullable_to_non_nullable
              as List<PeopleCardModel>,
      allEvents: null == allEvents
          ? _value._allEvents
          : allEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      hotEvents: null == hotEvents
          ? _value._hotEvents
          : hotEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      normalEvents: null == normalEvents
          ? _value._normalEvents
          : normalEvents // ignore: cast_nullable_to_non_nullable
              as List<EventListDomainModel>,
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
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
      {this.selectedEventId = null,
      this.isLoading = true,
      final List<PeopleCardModel> selectedEventPeople = const [],
      final List<EventListDomainModel> allEvents = const [],
      final List<EventListDomainModel> hotEvents = const [],
      final List<EventListDomainModel> normalEvents = const [],
      this.categorySelected = "",
      this.error = ""})
      : _selectedEventPeople = selectedEventPeople,
        _allEvents = allEvents,
        _hotEvents = hotEvents,
        _normalEvents = normalEvents;

  @override
  @JsonKey()
  final int? selectedEventId;
  @override
  @JsonKey()
  final bool isLoading;
  final List<PeopleCardModel> _selectedEventPeople;
  @override
  @JsonKey()
  List<PeopleCardModel> get selectedEventPeople {
    if (_selectedEventPeople is EqualUnmodifiableListView)
      return _selectedEventPeople;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedEventPeople);
  }

  final List<EventListDomainModel> _allEvents;
  @override
  @JsonKey()
  List<EventListDomainModel> get allEvents {
    if (_allEvents is EqualUnmodifiableListView) return _allEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allEvents);
  }

  final List<EventListDomainModel> _hotEvents;
  @override
  @JsonKey()
  List<EventListDomainModel> get hotEvents {
    if (_hotEvents is EqualUnmodifiableListView) return _hotEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hotEvents);
  }

  final List<EventListDomainModel> _normalEvents;
  @override
  @JsonKey()
  List<EventListDomainModel> get normalEvents {
    if (_normalEvents is EqualUnmodifiableListView) return _normalEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_normalEvents);
  }

  @override
  @JsonKey()
  final String categorySelected;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'EventBaseState.initial(selectedEventId: $selectedEventId, isLoading: $isLoading, selectedEventPeople: $selectedEventPeople, allEvents: $allEvents, hotEvents: $hotEvents, normalEvents: $normalEvents, categorySelected: $categorySelected, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.selectedEventId, selectedEventId) ||
                other.selectedEventId == selectedEventId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._selectedEventPeople, _selectedEventPeople) &&
            const DeepCollectionEquality()
                .equals(other._allEvents, _allEvents) &&
            const DeepCollectionEquality()
                .equals(other._hotEvents, _hotEvents) &&
            const DeepCollectionEquality()
                .equals(other._normalEvents, _normalEvents) &&
            (identical(other.categorySelected, categorySelected) ||
                other.categorySelected == categorySelected) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedEventId,
      isLoading,
      const DeepCollectionEquality().hash(_selectedEventPeople),
      const DeepCollectionEquality().hash(_allEvents),
      const DeepCollectionEquality().hash(_hotEvents),
      const DeepCollectionEquality().hash(_normalEvents),
      categorySelected,
      error);

  /// Create a copy of EventBaseState
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
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
            String error)
        initial,
  }) {
    return initial(selectedEventId, isLoading, selectedEventPeople, allEvents,
        hotEvents, normalEvents, categorySelected, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
            String error)?
        initial,
  }) {
    return initial?.call(selectedEventId, isLoading, selectedEventPeople,
        allEvents, hotEvents, normalEvents, categorySelected, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? selectedEventId,
            bool isLoading,
            List<PeopleCardModel> selectedEventPeople,
            List<EventListDomainModel> allEvents,
            List<EventListDomainModel> hotEvents,
            List<EventListDomainModel> normalEvents,
            String categorySelected,
            String error)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(selectedEventId, isLoading, selectedEventPeople, allEvents,
          hotEvents, normalEvents, categorySelected, error);
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

abstract class _Initial implements EventBaseState {
  const factory _Initial(
      {final int? selectedEventId,
      final bool isLoading,
      final List<PeopleCardModel> selectedEventPeople,
      final List<EventListDomainModel> allEvents,
      final List<EventListDomainModel> hotEvents,
      final List<EventListDomainModel> normalEvents,
      final String categorySelected,
      final String error}) = _$InitialImpl;

  @override
  int? get selectedEventId;
  @override
  bool get isLoading;
  @override
  List<PeopleCardModel> get selectedEventPeople;
  @override
  List<EventListDomainModel> get allEvents;
  @override
  List<EventListDomainModel> get hotEvents;
  @override
  List<EventListDomainModel> get normalEvents;
  @override
  String get categorySelected;
  @override
  String get error;

  /// Create a copy of EventBaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
