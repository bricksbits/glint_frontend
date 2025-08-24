// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_create_event_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdminCreateEventState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  CreateEventRequestDomainModel? get createEventBody =>
      throw _privateConstructorUsedError;
  EventDetailsDomainModel? get eventDetailModel =>
      throw _privateConstructorUsedError;
  List<File?> get pictureUploaded => throw _privateConstructorUsedError;
  bool get eventPublished => throw _privateConstructorUsedError;
  bool get eventUpdated => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            String error,
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            String error,
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            String error,
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)?
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

  /// Create a copy of AdminCreateEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminCreateEventStateCopyWith<AdminCreateEventState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminCreateEventStateCopyWith<$Res> {
  factory $AdminCreateEventStateCopyWith(AdminCreateEventState value,
          $Res Function(AdminCreateEventState) then) =
      _$AdminCreateEventStateCopyWithImpl<$Res, AdminCreateEventState>;
  @useResult
  $Res call(
      {bool isLoading,
      String error,
      CreateEventRequestDomainModel? createEventBody,
      EventDetailsDomainModel? eventDetailModel,
      List<File?> pictureUploaded,
      bool eventPublished,
      bool eventUpdated});
}

/// @nodoc
class _$AdminCreateEventStateCopyWithImpl<$Res,
        $Val extends AdminCreateEventState>
    implements $AdminCreateEventStateCopyWith<$Res> {
  _$AdminCreateEventStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminCreateEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = null,
    Object? createEventBody = freezed,
    Object? eventDetailModel = freezed,
    Object? pictureUploaded = null,
    Object? eventPublished = null,
    Object? eventUpdated = null,
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
      createEventBody: freezed == createEventBody
          ? _value.createEventBody
          : createEventBody // ignore: cast_nullable_to_non_nullable
              as CreateEventRequestDomainModel?,
      eventDetailModel: freezed == eventDetailModel
          ? _value.eventDetailModel
          : eventDetailModel // ignore: cast_nullable_to_non_nullable
              as EventDetailsDomainModel?,
      pictureUploaded: null == pictureUploaded
          ? _value.pictureUploaded
          : pictureUploaded // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      eventPublished: null == eventPublished
          ? _value.eventPublished
          : eventPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      eventUpdated: null == eventUpdated
          ? _value.eventUpdated
          : eventUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $AdminCreateEventStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String error,
      CreateEventRequestDomainModel? createEventBody,
      EventDetailsDomainModel? eventDetailModel,
      List<File?> pictureUploaded,
      bool eventPublished,
      bool eventUpdated});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AdminCreateEventStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminCreateEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = null,
    Object? createEventBody = freezed,
    Object? eventDetailModel = freezed,
    Object? pictureUploaded = null,
    Object? eventPublished = null,
    Object? eventUpdated = null,
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
      createEventBody: freezed == createEventBody
          ? _value.createEventBody
          : createEventBody // ignore: cast_nullable_to_non_nullable
              as CreateEventRequestDomainModel?,
      eventDetailModel: freezed == eventDetailModel
          ? _value.eventDetailModel
          : eventDetailModel // ignore: cast_nullable_to_non_nullable
              as EventDetailsDomainModel?,
      pictureUploaded: null == pictureUploaded
          ? _value._pictureUploaded
          : pictureUploaded // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      eventPublished: null == eventPublished
          ? _value.eventPublished
          : eventPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      eventUpdated: null == eventUpdated
          ? _value.eventUpdated
          : eventUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.isLoading = false,
      this.error = "",
      this.createEventBody = null,
      this.eventDetailModel = null,
      final List<File?> pictureUploaded = const [],
      this.eventPublished = false,
      this.eventUpdated = false})
      : _pictureUploaded = pictureUploaded;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final CreateEventRequestDomainModel? createEventBody;
  @override
  @JsonKey()
  final EventDetailsDomainModel? eventDetailModel;
  final List<File?> _pictureUploaded;
  @override
  @JsonKey()
  List<File?> get pictureUploaded {
    if (_pictureUploaded is EqualUnmodifiableListView) return _pictureUploaded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictureUploaded);
  }

  @override
  @JsonKey()
  final bool eventPublished;
  @override
  @JsonKey()
  final bool eventUpdated;

  @override
  String toString() {
    return 'AdminCreateEventState.initial(isLoading: $isLoading, error: $error, createEventBody: $createEventBody, eventDetailModel: $eventDetailModel, pictureUploaded: $pictureUploaded, eventPublished: $eventPublished, eventUpdated: $eventUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.createEventBody, createEventBody) ||
                other.createEventBody == createEventBody) &&
            (identical(other.eventDetailModel, eventDetailModel) ||
                other.eventDetailModel == eventDetailModel) &&
            const DeepCollectionEquality()
                .equals(other._pictureUploaded, _pictureUploaded) &&
            (identical(other.eventPublished, eventPublished) ||
                other.eventPublished == eventPublished) &&
            (identical(other.eventUpdated, eventUpdated) ||
                other.eventUpdated == eventUpdated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      error,
      createEventBody,
      eventDetailModel,
      const DeepCollectionEquality().hash(_pictureUploaded),
      eventPublished,
      eventUpdated);

  /// Create a copy of AdminCreateEventState
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
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)
        initial,
  }) {
    return initial(isLoading, error, createEventBody, eventDetailModel,
        pictureUploaded, eventPublished, eventUpdated);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            String error,
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)?
        initial,
  }) {
    return initial?.call(isLoading, error, createEventBody, eventDetailModel,
        pictureUploaded, eventPublished, eventUpdated);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            String error,
            CreateEventRequestDomainModel? createEventBody,
            EventDetailsDomainModel? eventDetailModel,
            List<File?> pictureUploaded,
            bool eventPublished,
            bool eventUpdated)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(isLoading, error, createEventBody, eventDetailModel,
          pictureUploaded, eventPublished, eventUpdated);
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

abstract class _Initial implements AdminCreateEventState {
  const factory _Initial(
      {final bool isLoading,
      final String error,
      final CreateEventRequestDomainModel? createEventBody,
      final EventDetailsDomainModel? eventDetailModel,
      final List<File?> pictureUploaded,
      final bool eventPublished,
      final bool eventUpdated}) = _$InitialImpl;

  @override
  bool get isLoading;
  @override
  String get error;
  @override
  CreateEventRequestDomainModel? get createEventBody;
  @override
  EventDetailsDomainModel? get eventDetailModel;
  @override
  List<File?> get pictureUploaded;
  @override
  bool get eventPublished;
  @override
  bool get eventUpdated;

  /// Create a copy of AdminCreateEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
