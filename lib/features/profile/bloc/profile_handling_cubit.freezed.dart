// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_handling_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileHandlingState {
  PeopleCardModel? get previewProfileModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PeopleCardModel? previewProfileModel) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PeopleCardModel? previewProfileModel)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PeopleCardModel? previewProfileModel)? initial,
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

  /// Create a copy of ProfileHandlingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileHandlingStateCopyWith<ProfileHandlingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileHandlingStateCopyWith<$Res> {
  factory $ProfileHandlingStateCopyWith(ProfileHandlingState value,
          $Res Function(ProfileHandlingState) then) =
      _$ProfileHandlingStateCopyWithImpl<$Res, ProfileHandlingState>;
  @useResult
  $Res call({PeopleCardModel? previewProfileModel});
}

/// @nodoc
class _$ProfileHandlingStateCopyWithImpl<$Res,
        $Val extends ProfileHandlingState>
    implements $ProfileHandlingStateCopyWith<$Res> {
  _$ProfileHandlingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileHandlingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previewProfileModel = freezed,
  }) {
    return _then(_value.copyWith(
      previewProfileModel: freezed == previewProfileModel
          ? _value.previewProfileModel
          : previewProfileModel // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ProfileHandlingStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PeopleCardModel? previewProfileModel});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ProfileHandlingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileHandlingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previewProfileModel = freezed,
  }) {
    return _then(_$InitialImpl(
      previewProfileModel: freezed == previewProfileModel
          ? _value.previewProfileModel
          : previewProfileModel // ignore: cast_nullable_to_non_nullable
              as PeopleCardModel?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({this.previewProfileModel = null});

  @override
  @JsonKey()
  final PeopleCardModel? previewProfileModel;

  @override
  String toString() {
    return 'ProfileHandlingState.initial(previewProfileModel: $previewProfileModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.previewProfileModel, previewProfileModel) ||
                other.previewProfileModel == previewProfileModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, previewProfileModel);

  /// Create a copy of ProfileHandlingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PeopleCardModel? previewProfileModel) initial,
  }) {
    return initial(previewProfileModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PeopleCardModel? previewProfileModel)? initial,
  }) {
    return initial?.call(previewProfileModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PeopleCardModel? previewProfileModel)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(previewProfileModel);
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

abstract class _Initial implements ProfileHandlingState {
  const factory _Initial({final PeopleCardModel? previewProfileModel}) =
      _$InitialImpl;

  @override
  PeopleCardModel? get previewProfileModel;

  /// Create a copy of ProfileHandlingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
