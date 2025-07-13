// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'people_cards_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PeopleCardsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeopleCardsEventCopyWith<$Res> {
  factory $PeopleCardsEventCopyWith(
          PeopleCardsEvent value, $Res Function(PeopleCardsEvent) then) =
      _$PeopleCardsEventCopyWithImpl<$Res, PeopleCardsEvent>;
}

/// @nodoc
class _$PeopleCardsEventCopyWithImpl<$Res, $Val extends PeopleCardsEvent>
    implements $PeopleCardsEventCopyWith<$Res> {
  _$PeopleCardsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeopleCardsEvent
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
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'PeopleCardsEvent.started()';
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
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements PeopleCardsEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$LoadingImpl(
      null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.isLoading);

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'PeopleCardsEvent.loading(isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return loading(isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return loading?.call(isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PeopleCardsEvent {
  const factory _Loading(final bool isLoading) = _$LoadingImpl;

  bool get isLoading;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchNextCardsImplCopyWith<$Res> {
  factory _$$FetchNextCardsImplCopyWith(_$FetchNextCardsImpl value,
          $Res Function(_$FetchNextCardsImpl) then) =
      __$$FetchNextCardsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int page, int index});
}

/// @nodoc
class __$$FetchNextCardsImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$FetchNextCardsImpl>
    implements _$$FetchNextCardsImplCopyWith<$Res> {
  __$$FetchNextCardsImplCopyWithImpl(
      _$FetchNextCardsImpl _value, $Res Function(_$FetchNextCardsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? index = null,
  }) {
    return _then(_$FetchNextCardsImpl(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchNextCardsImpl implements _FetchNextCards {
  const _$FetchNextCardsImpl(this.page, this.index);

  @override
  final int page;
  @override
  final int index;

  @override
  String toString() {
    return 'PeopleCardsEvent.fetchNextCards(page: $page, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNextCardsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page, index);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNextCardsImplCopyWith<_$FetchNextCardsImpl> get copyWith =>
      __$$FetchNextCardsImplCopyWithImpl<_$FetchNextCardsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return fetchNextCards(page, index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return fetchNextCards?.call(page, index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (fetchNextCards != null) {
      return fetchNextCards(page, index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return fetchNextCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return fetchNextCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (fetchNextCards != null) {
      return fetchNextCards(this);
    }
    return orElse();
  }
}

abstract class _FetchNextCards implements PeopleCardsEvent {
  const factory _FetchNextCards(final int page, final int index) =
      _$FetchNextCardsImpl;

  int get page;
  int get index;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchNextCardsImplCopyWith<_$FetchNextCardsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuperLikedImplCopyWith<$Res> {
  factory _$$SuperLikedImplCopyWith(
          _$SuperLikedImpl value, $Res Function(_$SuperLikedImpl) then) =
      __$$SuperLikedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String onUserId});
}

/// @nodoc
class __$$SuperLikedImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$SuperLikedImpl>
    implements _$$SuperLikedImplCopyWith<$Res> {
  __$$SuperLikedImplCopyWithImpl(
      _$SuperLikedImpl _value, $Res Function(_$SuperLikedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onUserId = null,
  }) {
    return _then(_$SuperLikedImpl(
      null == onUserId
          ? _value.onUserId
          : onUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuperLikedImpl implements _SuperLiked {
  const _$SuperLikedImpl(this.onUserId);

  @override
  final String onUserId;

  @override
  String toString() {
    return 'PeopleCardsEvent.onSuperLiked(onUserId: $onUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuperLikedImpl &&
            (identical(other.onUserId, onUserId) ||
                other.onUserId == onUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onUserId);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuperLikedImplCopyWith<_$SuperLikedImpl> get copyWith =>
      __$$SuperLikedImplCopyWithImpl<_$SuperLikedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return onSuperLiked(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return onSuperLiked?.call(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onSuperLiked != null) {
      return onSuperLiked(onUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return onSuperLiked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return onSuperLiked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onSuperLiked != null) {
      return onSuperLiked(this);
    }
    return orElse();
  }
}

abstract class _SuperLiked implements PeopleCardsEvent {
  const factory _SuperLiked(final String onUserId) = _$SuperLikedImpl;

  String get onUserId;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuperLikedImplCopyWith<_$SuperLikedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RightSwipedImplCopyWith<$Res> {
  factory _$$RightSwipedImplCopyWith(
          _$RightSwipedImpl value, $Res Function(_$RightSwipedImpl) then) =
      __$$RightSwipedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String onUserId});
}

/// @nodoc
class __$$RightSwipedImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$RightSwipedImpl>
    implements _$$RightSwipedImplCopyWith<$Res> {
  __$$RightSwipedImplCopyWithImpl(
      _$RightSwipedImpl _value, $Res Function(_$RightSwipedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onUserId = null,
  }) {
    return _then(_$RightSwipedImpl(
      null == onUserId
          ? _value.onUserId
          : onUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RightSwipedImpl implements _RightSwiped {
  const _$RightSwipedImpl(this.onUserId);

  @override
  final String onUserId;

  @override
  String toString() {
    return 'PeopleCardsEvent.onRightSwiped(onUserId: $onUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RightSwipedImpl &&
            (identical(other.onUserId, onUserId) ||
                other.onUserId == onUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onUserId);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RightSwipedImplCopyWith<_$RightSwipedImpl> get copyWith =>
      __$$RightSwipedImplCopyWithImpl<_$RightSwipedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return onRightSwiped(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return onRightSwiped?.call(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onRightSwiped != null) {
      return onRightSwiped(onUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return onRightSwiped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return onRightSwiped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onRightSwiped != null) {
      return onRightSwiped(this);
    }
    return orElse();
  }
}

abstract class _RightSwiped implements PeopleCardsEvent {
  const factory _RightSwiped(final String onUserId) = _$RightSwipedImpl;

  String get onUserId;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RightSwipedImplCopyWith<_$RightSwipedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeftSwipedImplCopyWith<$Res> {
  factory _$$LeftSwipedImplCopyWith(
          _$LeftSwipedImpl value, $Res Function(_$LeftSwipedImpl) then) =
      __$$LeftSwipedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String onUserId});
}

/// @nodoc
class __$$LeftSwipedImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$LeftSwipedImpl>
    implements _$$LeftSwipedImplCopyWith<$Res> {
  __$$LeftSwipedImplCopyWithImpl(
      _$LeftSwipedImpl _value, $Res Function(_$LeftSwipedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onUserId = null,
  }) {
    return _then(_$LeftSwipedImpl(
      null == onUserId
          ? _value.onUserId
          : onUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LeftSwipedImpl implements _LeftSwiped {
  const _$LeftSwipedImpl(this.onUserId);

  @override
  final String onUserId;

  @override
  String toString() {
    return 'PeopleCardsEvent.onLeftSwiped(onUserId: $onUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeftSwipedImpl &&
            (identical(other.onUserId, onUserId) ||
                other.onUserId == onUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onUserId);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeftSwipedImplCopyWith<_$LeftSwipedImpl> get copyWith =>
      __$$LeftSwipedImplCopyWithImpl<_$LeftSwipedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return onLeftSwiped(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return onLeftSwiped?.call(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onLeftSwiped != null) {
      return onLeftSwiped(onUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return onLeftSwiped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return onLeftSwiped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onLeftSwiped != null) {
      return onLeftSwiped(this);
    }
    return orElse();
  }
}

abstract class _LeftSwiped implements PeopleCardsEvent {
  const factory _LeftSwiped(final String onUserId) = _$LeftSwipedImpl;

  String get onUserId;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeftSwipedImplCopyWith<_$LeftSwipedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$onMatchMadeImplCopyWith<$Res> {
  factory _$$onMatchMadeImplCopyWith(
          _$onMatchMadeImpl value, $Res Function(_$onMatchMadeImpl) then) =
      __$$onMatchMadeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String onUserId});
}

/// @nodoc
class __$$onMatchMadeImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$onMatchMadeImpl>
    implements _$$onMatchMadeImplCopyWith<$Res> {
  __$$onMatchMadeImplCopyWithImpl(
      _$onMatchMadeImpl _value, $Res Function(_$onMatchMadeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onUserId = null,
  }) {
    return _then(_$onMatchMadeImpl(
      null == onUserId
          ? _value.onUserId
          : onUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$onMatchMadeImpl implements _onMatchMade {
  const _$onMatchMadeImpl(this.onUserId);

  @override
  final String onUserId;

  @override
  String toString() {
    return 'PeopleCardsEvent.onMatchMade(onUserId: $onUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$onMatchMadeImpl &&
            (identical(other.onUserId, onUserId) ||
                other.onUserId == onUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onUserId);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$onMatchMadeImplCopyWith<_$onMatchMadeImpl> get copyWith =>
      __$$onMatchMadeImplCopyWithImpl<_$onMatchMadeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return onMatchMade(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return onMatchMade?.call(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onMatchMade != null) {
      return onMatchMade(onUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return onMatchMade(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return onMatchMade?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (onMatchMade != null) {
      return onMatchMade(this);
    }
    return orElse();
  }
}

abstract class _onMatchMade implements PeopleCardsEvent {
  const factory _onMatchMade(final String onUserId) = _$onMatchMadeImpl;

  String get onUserId;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$onMatchMadeImplCopyWith<_$onMatchMadeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$shareProfileImplCopyWith<$Res> {
  factory _$$shareProfileImplCopyWith(
          _$shareProfileImpl value, $Res Function(_$shareProfileImpl) then) =
      __$$shareProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String onUserId});
}

/// @nodoc
class __$$shareProfileImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$shareProfileImpl>
    implements _$$shareProfileImplCopyWith<$Res> {
  __$$shareProfileImplCopyWithImpl(
      _$shareProfileImpl _value, $Res Function(_$shareProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onUserId = null,
  }) {
    return _then(_$shareProfileImpl(
      null == onUserId
          ? _value.onUserId
          : onUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$shareProfileImpl implements _shareProfile {
  const _$shareProfileImpl(this.onUserId);

  @override
  final String onUserId;

  @override
  String toString() {
    return 'PeopleCardsEvent.shareProfile(onUserId: $onUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$shareProfileImpl &&
            (identical(other.onUserId, onUserId) ||
                other.onUserId == onUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onUserId);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$shareProfileImplCopyWith<_$shareProfileImpl> get copyWith =>
      __$$shareProfileImplCopyWithImpl<_$shareProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return shareProfile(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return shareProfile?.call(onUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (shareProfile != null) {
      return shareProfile(onUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return shareProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return shareProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (shareProfile != null) {
      return shareProfile(this);
    }
    return orElse();
  }
}

abstract class _shareProfile implements PeopleCardsEvent {
  const factory _shareProfile(final String onUserId) = _$shareProfileImpl;

  String get onUserId;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$shareProfileImplCopyWith<_$shareProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$emitNewStateImplCopyWith<$Res> {
  factory _$$emitNewStateImplCopyWith(
          _$emitNewStateImpl value, $Res Function(_$emitNewStateImpl) then) =
      __$$emitNewStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PeopleCardsState newState});

  $PeopleCardsStateCopyWith<$Res> get newState;
}

/// @nodoc
class __$$emitNewStateImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$emitNewStateImpl>
    implements _$$emitNewStateImplCopyWith<$Res> {
  __$$emitNewStateImplCopyWithImpl(
      _$emitNewStateImpl _value, $Res Function(_$emitNewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newState = null,
  }) {
    return _then(_$emitNewStateImpl(
      null == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as PeopleCardsState,
    ));
  }

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeopleCardsStateCopyWith<$Res> get newState {
    return $PeopleCardsStateCopyWith<$Res>(_value.newState, (value) {
      return _then(_value.copyWith(newState: value));
    });
  }
}

/// @nodoc

class _$emitNewStateImpl implements _emitNewState {
  const _$emitNewStateImpl(this.newState);

  @override
  final PeopleCardsState newState;

  @override
  String toString() {
    return 'PeopleCardsEvent.emitNewState(newState: $newState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$emitNewStateImpl &&
            (identical(other.newState, newState) ||
                other.newState == newState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newState);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$emitNewStateImplCopyWith<_$emitNewStateImpl> get copyWith =>
      __$$emitNewStateImplCopyWithImpl<_$emitNewStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return emitNewState(newState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return emitNewState?.call(newState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return emitNewState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return emitNewState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (emitNewState != null) {
      return emitNewState(this);
    }
    return orElse();
  }
}

abstract class _emitNewState implements PeopleCardsEvent {
  const factory _emitNewState(final PeopleCardsState newState) =
      _$emitNewStateImpl;

  PeopleCardsState get newState;

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$emitNewStateImplCopyWith<_$emitNewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$flushSwipeCardsImplCopyWith<$Res> {
  factory _$$flushSwipeCardsImplCopyWith(_$flushSwipeCardsImpl value,
          $Res Function(_$flushSwipeCardsImpl) then) =
      __$$flushSwipeCardsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$flushSwipeCardsImplCopyWithImpl<$Res>
    extends _$PeopleCardsEventCopyWithImpl<$Res, _$flushSwipeCardsImpl>
    implements _$$flushSwipeCardsImplCopyWith<$Res> {
  __$$flushSwipeCardsImplCopyWithImpl(
      _$flushSwipeCardsImpl _value, $Res Function(_$flushSwipeCardsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$flushSwipeCardsImpl implements _flushSwipeCards {
  const _$flushSwipeCardsImpl();

  @override
  String toString() {
    return 'PeopleCardsEvent.flushSwipeCards()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$flushSwipeCardsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool isLoading) loading,
    required TResult Function(int page, int index) fetchNextCards,
    required TResult Function(String onUserId) onSuperLiked,
    required TResult Function(String onUserId) onRightSwiped,
    required TResult Function(String onUserId) onLeftSwiped,
    required TResult Function(String onUserId) onMatchMade,
    required TResult Function(String onUserId) shareProfile,
    required TResult Function(PeopleCardsState newState) emitNewState,
    required TResult Function() flushSwipeCards,
  }) {
    return flushSwipeCards();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool isLoading)? loading,
    TResult? Function(int page, int index)? fetchNextCards,
    TResult? Function(String onUserId)? onSuperLiked,
    TResult? Function(String onUserId)? onRightSwiped,
    TResult? Function(String onUserId)? onLeftSwiped,
    TResult? Function(String onUserId)? onMatchMade,
    TResult? Function(String onUserId)? shareProfile,
    TResult? Function(PeopleCardsState newState)? emitNewState,
    TResult? Function()? flushSwipeCards,
  }) {
    return flushSwipeCards?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool isLoading)? loading,
    TResult Function(int page, int index)? fetchNextCards,
    TResult Function(String onUserId)? onSuperLiked,
    TResult Function(String onUserId)? onRightSwiped,
    TResult Function(String onUserId)? onLeftSwiped,
    TResult Function(String onUserId)? onMatchMade,
    TResult Function(String onUserId)? shareProfile,
    TResult Function(PeopleCardsState newState)? emitNewState,
    TResult Function()? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (flushSwipeCards != null) {
      return flushSwipeCards();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Loading value) loading,
    required TResult Function(_FetchNextCards value) fetchNextCards,
    required TResult Function(_SuperLiked value) onSuperLiked,
    required TResult Function(_RightSwiped value) onRightSwiped,
    required TResult Function(_LeftSwiped value) onLeftSwiped,
    required TResult Function(_onMatchMade value) onMatchMade,
    required TResult Function(_shareProfile value) shareProfile,
    required TResult Function(_emitNewState value) emitNewState,
    required TResult Function(_flushSwipeCards value) flushSwipeCards,
  }) {
    return flushSwipeCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_FetchNextCards value)? fetchNextCards,
    TResult? Function(_SuperLiked value)? onSuperLiked,
    TResult? Function(_RightSwiped value)? onRightSwiped,
    TResult? Function(_LeftSwiped value)? onLeftSwiped,
    TResult? Function(_onMatchMade value)? onMatchMade,
    TResult? Function(_shareProfile value)? shareProfile,
    TResult? Function(_emitNewState value)? emitNewState,
    TResult? Function(_flushSwipeCards value)? flushSwipeCards,
  }) {
    return flushSwipeCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Loading value)? loading,
    TResult Function(_FetchNextCards value)? fetchNextCards,
    TResult Function(_SuperLiked value)? onSuperLiked,
    TResult Function(_RightSwiped value)? onRightSwiped,
    TResult Function(_LeftSwiped value)? onLeftSwiped,
    TResult Function(_onMatchMade value)? onMatchMade,
    TResult Function(_shareProfile value)? shareProfile,
    TResult Function(_emitNewState value)? emitNewState,
    TResult Function(_flushSwipeCards value)? flushSwipeCards,
    required TResult orElse(),
  }) {
    if (flushSwipeCards != null) {
      return flushSwipeCards(this);
    }
    return orElse();
  }
}

abstract class _flushSwipeCards implements PeopleCardsEvent {
  const factory _flushSwipeCards() = _$flushSwipeCardsImpl;
}

/// @nodoc
mixin _$PeopleCardsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<PeopleCardModel> get cardList => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  int get currentPaginatedIndex => throw _privateConstructorUsedError;
  int get currentPaginatedPage => throw _privateConstructorUsedError;
  PeopleCardModel? get lastSwipedProfile => throw _privateConstructorUsedError;
  PeopleCardModel? get matchUpProfile => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)
        ignite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)?
        ignite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)?
        ignite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Ignite value) ignite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Ignite value)? ignite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Ignite value)? ignite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PeopleCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeopleCardsStateCopyWith<PeopleCardsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeopleCardsStateCopyWith<$Res> {
  factory $PeopleCardsStateCopyWith(
          PeopleCardsState value, $Res Function(PeopleCardsState) then) =
      _$PeopleCardsStateCopyWithImpl<$Res, PeopleCardsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<PeopleCardModel> cardList,
      String userId,
      String error,
      int currentPaginatedIndex,
      int currentPaginatedPage,
      PeopleCardModel? lastSwipedProfile,
      PeopleCardModel? matchUpProfile});
}

/// @nodoc
class _$PeopleCardsStateCopyWithImpl<$Res, $Val extends PeopleCardsState>
    implements $PeopleCardsStateCopyWith<$Res> {
  _$PeopleCardsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeopleCardsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? cardList = null,
    Object? userId = null,
    Object? error = null,
    Object? currentPaginatedIndex = null,
    Object? currentPaginatedPage = null,
    Object? lastSwipedProfile = freezed,
    Object? matchUpProfile = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cardList: null == cardList
          ? _value.cardList
          : cardList // ignore: cast_nullable_to_non_nullable
              as List<PeopleCardModel>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      currentPaginatedIndex: null == currentPaginatedIndex
          ? _value.currentPaginatedIndex
          : currentPaginatedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      currentPaginatedPage: null == currentPaginatedPage
          ? _value.currentPaginatedPage
          : currentPaginatedPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastSwipedProfile: freezed == lastSwipedProfile
          ? _value.lastSwipedProfile
          : lastSwipedProfile // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
      matchUpProfile: freezed == matchUpProfile
          ? _value.matchUpProfile
          : matchUpProfile // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IgniteImplCopyWith<$Res>
    implements $PeopleCardsStateCopyWith<$Res> {
  factory _$$IgniteImplCopyWith(
          _$IgniteImpl value, $Res Function(_$IgniteImpl) then) =
      __$$IgniteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<PeopleCardModel> cardList,
      String userId,
      String error,
      int currentPaginatedIndex,
      int currentPaginatedPage,
      PeopleCardModel? lastSwipedProfile,
      PeopleCardModel? matchUpProfile});
}

/// @nodoc
class __$$IgniteImplCopyWithImpl<$Res>
    extends _$PeopleCardsStateCopyWithImpl<$Res, _$IgniteImpl>
    implements _$$IgniteImplCopyWith<$Res> {
  __$$IgniteImplCopyWithImpl(
      _$IgniteImpl _value, $Res Function(_$IgniteImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeopleCardsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? cardList = null,
    Object? userId = null,
    Object? error = null,
    Object? currentPaginatedIndex = null,
    Object? currentPaginatedPage = null,
    Object? lastSwipedProfile = freezed,
    Object? matchUpProfile = freezed,
  }) {
    return _then(_$IgniteImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cardList: null == cardList
          ? _value._cardList
          : cardList // ignore: cast_nullable_to_non_nullable
              as List<PeopleCardModel>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      currentPaginatedIndex: null == currentPaginatedIndex
          ? _value.currentPaginatedIndex
          : currentPaginatedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      currentPaginatedPage: null == currentPaginatedPage
          ? _value.currentPaginatedPage
          : currentPaginatedPage // ignore: cast_nullable_to_non_nullable
              as int,
      lastSwipedProfile: freezed == lastSwipedProfile
          ? _value.lastSwipedProfile
          : lastSwipedProfile // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
      matchUpProfile: freezed == matchUpProfile
          ? _value.matchUpProfile
          : matchUpProfile // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
    ));
  }
}

/// @nodoc

class _$IgniteImpl implements _Ignite {
  const _$IgniteImpl(
      {this.isLoading = true,
      final List<PeopleCardModel> cardList = const [],
      this.userId = "",
      this.error = "",
      this.currentPaginatedIndex = 1,
      this.currentPaginatedPage = 0,
      this.lastSwipedProfile = null,
      this.matchUpProfile = null})
      : _cardList = cardList;

  @override
  @JsonKey()
  final bool isLoading;
  final List<PeopleCardModel> _cardList;
  @override
  @JsonKey()
  List<PeopleCardModel> get cardList {
    if (_cardList is EqualUnmodifiableListView) return _cardList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardList);
  }

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final int currentPaginatedIndex;
  @override
  @JsonKey()
  final int currentPaginatedPage;
  @override
  @JsonKey()
  final PeopleCardModel? lastSwipedProfile;
  @override
  @JsonKey()
  final PeopleCardModel? matchUpProfile;

  @override
  String toString() {
    return 'PeopleCardsState.ignite(isLoading: $isLoading, cardList: $cardList, userId: $userId, error: $error, currentPaginatedIndex: $currentPaginatedIndex, currentPaginatedPage: $currentPaginatedPage, lastSwipedProfile: $lastSwipedProfile, matchUpProfile: $matchUpProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IgniteImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._cardList, _cardList) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentPaginatedIndex, currentPaginatedIndex) ||
                other.currentPaginatedIndex == currentPaginatedIndex) &&
            (identical(other.currentPaginatedPage, currentPaginatedPage) ||
                other.currentPaginatedPage == currentPaginatedPage) &&
            (identical(other.lastSwipedProfile, lastSwipedProfile) ||
                other.lastSwipedProfile == lastSwipedProfile) &&
            (identical(other.matchUpProfile, matchUpProfile) ||
                other.matchUpProfile == matchUpProfile));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_cardList),
      userId,
      error,
      currentPaginatedIndex,
      currentPaginatedPage,
      lastSwipedProfile,
      matchUpProfile);

  /// Create a copy of PeopleCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IgniteImplCopyWith<_$IgniteImpl> get copyWith =>
      __$$IgniteImplCopyWithImpl<_$IgniteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)
        ignite,
  }) {
    return ignite(isLoading, cardList, userId, error, currentPaginatedIndex,
        currentPaginatedPage, lastSwipedProfile, matchUpProfile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)?
        ignite,
  }) {
    return ignite?.call(
        isLoading,
        cardList,
        userId,
        error,
        currentPaginatedIndex,
        currentPaginatedPage,
        lastSwipedProfile,
        matchUpProfile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            List<PeopleCardModel> cardList,
            String userId,
            String error,
            int currentPaginatedIndex,
            int currentPaginatedPage,
            PeopleCardModel? lastSwipedProfile,
            PeopleCardModel? matchUpProfile)?
        ignite,
    required TResult orElse(),
  }) {
    if (ignite != null) {
      return ignite(isLoading, cardList, userId, error, currentPaginatedIndex,
          currentPaginatedPage, lastSwipedProfile, matchUpProfile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Ignite value) ignite,
  }) {
    return ignite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Ignite value)? ignite,
  }) {
    return ignite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Ignite value)? ignite,
    required TResult orElse(),
  }) {
    if (ignite != null) {
      return ignite(this);
    }
    return orElse();
  }
}

abstract class _Ignite implements PeopleCardsState {
  const factory _Ignite(
      {final bool isLoading,
      final List<PeopleCardModel> cardList,
      final String userId,
      final String error,
      final int currentPaginatedIndex,
      final int currentPaginatedPage,
      final PeopleCardModel? lastSwipedProfile,
      final PeopleCardModel? matchUpProfile}) = _$IgniteImpl;

  @override
  bool get isLoading;
  @override
  List<PeopleCardModel> get cardList;
  @override
  String get userId;
  @override
  String get error;
  @override
  int get currentPaginatedIndex;
  @override
  int get currentPaginatedPage;
  @override
  PeopleCardModel? get lastSwipedProfile;
  @override
  PeopleCardModel? get matchUpProfile;

  /// Create a copy of PeopleCardsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IgniteImplCopyWith<_$IgniteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
