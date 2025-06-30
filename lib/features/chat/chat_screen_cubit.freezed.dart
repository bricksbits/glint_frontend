// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatScreenState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError; // For Stories
  List<ViewStoryModel>? get stories => throw _privateConstructorUsedError;
  int? get selectedIndex =>
      throw _privateConstructorUsedError; // For Recent Matches
  List<RecentMatchesModel>? get recentMatches =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)?
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

  /// Create a copy of ChatScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatScreenStateCopyWith<ChatScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatScreenStateCopyWith<$Res> {
  factory $ChatScreenStateCopyWith(
          ChatScreenState value, $Res Function(ChatScreenState) then) =
      _$ChatScreenStateCopyWithImpl<$Res, ChatScreenState>;
  @useResult
  $Res call(
      {bool isLoading,
      String error,
      List<ViewStoryModel>? stories,
      int? selectedIndex,
      List<RecentMatchesModel>? recentMatches});
}

/// @nodoc
class _$ChatScreenStateCopyWithImpl<$Res, $Val extends ChatScreenState>
    implements $ChatScreenStateCopyWith<$Res> {
  _$ChatScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = null,
    Object? stories = freezed,
    Object? selectedIndex = freezed,
    Object? recentMatches = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      stories: freezed == stories
          ? _value.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<ViewStoryModel>?,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      recentMatches: freezed == recentMatches
          ? _value.recentMatches
          : recentMatches // ignore: cast_nullable_to_non_nullable
              as List<RecentMatchesModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ChatScreenStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String error,
      List<ViewStoryModel>? stories,
      int? selectedIndex,
      List<RecentMatchesModel>? recentMatches});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ChatScreenStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = null,
    Object? stories = freezed,
    Object? selectedIndex = freezed,
    Object? recentMatches = freezed,
  }) {
    return _then(_$InitialImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      stories: freezed == stories
          ? _value._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<ViewStoryModel>?,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      recentMatches: freezed == recentMatches
          ? _value._recentMatches
          : recentMatches // ignore: cast_nullable_to_non_nullable
              as List<RecentMatchesModel>?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.isLoading = false,
      this.error = "",
      final List<ViewStoryModel>? stories = const [],
      this.selectedIndex = null,
      final List<RecentMatchesModel>? recentMatches = null})
      : _stories = stories,
        _recentMatches = recentMatches;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String error;
// For Stories
  final List<ViewStoryModel>? _stories;
// For Stories
  @override
  @JsonKey()
  List<ViewStoryModel>? get stories {
    final value = _stories;
    if (value == null) return null;
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int? selectedIndex;
// For Recent Matches
  final List<RecentMatchesModel>? _recentMatches;
// For Recent Matches
  @override
  @JsonKey()
  List<RecentMatchesModel>? get recentMatches {
    final value = _recentMatches;
    if (value == null) return null;
    if (_recentMatches is EqualUnmodifiableListView) return _recentMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatScreenState.initial(isLoading: $isLoading, error: $error, stories: $stories, selectedIndex: $selectedIndex, recentMatches: $recentMatches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._stories, _stories) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            const DeepCollectionEquality()
                .equals(other._recentMatches, _recentMatches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      const DeepCollectionEquality().hash(_stories),
      selectedIndex,
      const DeepCollectionEquality().hash(_recentMatches));

  /// Create a copy of ChatScreenState
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
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)
        initial,
  }) {
    return initial(isLoading, error, stories, selectedIndex, recentMatches);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)?
        initial,
  }) {
    return initial?.call(
        isLoading, error, stories, selectedIndex, recentMatches);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            String error,
            List<ViewStoryModel>? stories,
            int? selectedIndex,
            List<RecentMatchesModel>? recentMatches)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(isLoading, error, stories, selectedIndex, recentMatches);
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

abstract class _Initial implements ChatScreenState {
  const factory _Initial(
      {final bool isLoading,
      final String error,
      final List<ViewStoryModel>? stories,
      final int? selectedIndex,
      final List<RecentMatchesModel>? recentMatches}) = _$InitialImpl;

  @override
  bool get isLoading;
  @override
  String get error; // For Stories
  @override
  List<ViewStoryModel>? get stories;
  @override
  int? get selectedIndex; // For Recent Matches
  @override
  List<RecentMatchesModel>? get recentMatches;

  /// Create a copy of ChatScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
