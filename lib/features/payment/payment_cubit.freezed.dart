// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentState {
  String? get orderId => throw _privateConstructorUsedError;
  String? get key => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get razorpayKey => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  RazorpayOrderModel? get razorpayModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)
        initiate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)?
        initiate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)?
        initiate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initiate value) initiate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initiate value)? initiate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initiate value)? initiate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentStateCopyWith<PaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
          PaymentState value, $Res Function(PaymentState) then) =
      _$PaymentStateCopyWithImpl<$Res, PaymentState>;
  @useResult
  $Res call(
      {String? orderId,
      String? key,
      String? amount,
      String? razorpayKey,
      String? name,
      String? description,
      RazorpayOrderModel? razorpayModel});
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = freezed,
    Object? key = freezed,
    Object? amount = freezed,
    Object? razorpayKey = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? razorpayModel = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayKey: freezed == razorpayKey
          ? _value.razorpayKey
          : razorpayKey // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayModel: freezed == razorpayModel
          ? _value.razorpayModel
          : razorpayModel // ignore: cast_nullable_to_non_nullable
              as RazorpayOrderModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitiateImplCopyWith<$Res>
    implements $PaymentStateCopyWith<$Res> {
  factory _$$InitiateImplCopyWith(
          _$InitiateImpl value, $Res Function(_$InitiateImpl) then) =
      __$$InitiateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? orderId,
      String? key,
      String? amount,
      String? razorpayKey,
      String? name,
      String? description,
      RazorpayOrderModel? razorpayModel});
}

/// @nodoc
class __$$InitiateImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$InitiateImpl>
    implements _$$InitiateImplCopyWith<$Res> {
  __$$InitiateImplCopyWithImpl(
      _$InitiateImpl _value, $Res Function(_$InitiateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = freezed,
    Object? key = freezed,
    Object? amount = freezed,
    Object? razorpayKey = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? razorpayModel = freezed,
  }) {
    return _then(_$InitiateImpl(
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayKey: freezed == razorpayKey
          ? _value.razorpayKey
          : razorpayKey // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayModel: freezed == razorpayModel
          ? _value.razorpayModel
          : razorpayModel // ignore: cast_nullable_to_non_nullable
              as RazorpayOrderModel?,
    ));
  }
}

/// @nodoc

class _$InitiateImpl implements _Initiate {
  const _$InitiateImpl(
      {this.orderId = "",
      this.key = "",
      this.amount = "",
      this.razorpayKey = "",
      this.name = "",
      this.description = "",
      this.razorpayModel = null});

  @override
  @JsonKey()
  final String? orderId;
  @override
  @JsonKey()
  final String? key;
  @override
  @JsonKey()
  final String? amount;
  @override
  @JsonKey()
  final String? razorpayKey;
  @override
  @JsonKey()
  final String? name;
  @override
  @JsonKey()
  final String? description;
  @override
  @JsonKey()
  final RazorpayOrderModel? razorpayModel;

  @override
  String toString() {
    return 'PaymentState.initiate(orderId: $orderId, key: $key, amount: $amount, razorpayKey: $razorpayKey, name: $name, description: $description, razorpayModel: $razorpayModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.razorpayKey, razorpayKey) ||
                other.razorpayKey == razorpayKey) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.razorpayModel, razorpayModel) ||
                other.razorpayModel == razorpayModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, key, amount,
      razorpayKey, name, description, razorpayModel);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateImplCopyWith<_$InitiateImpl> get copyWith =>
      __$$InitiateImplCopyWithImpl<_$InitiateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)
        initiate,
  }) {
    return initiate(
        orderId, key, amount, razorpayKey, name, description, razorpayModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)?
        initiate,
  }) {
    return initiate?.call(
        orderId, key, amount, razorpayKey, name, description, razorpayModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? orderId,
            String? key,
            String? amount,
            String? razorpayKey,
            String? name,
            String? description,
            RazorpayOrderModel? razorpayModel)?
        initiate,
    required TResult orElse(),
  }) {
    if (initiate != null) {
      return initiate(
          orderId, key, amount, razorpayKey, name, description, razorpayModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initiate value) initiate,
  }) {
    return initiate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initiate value)? initiate,
  }) {
    return initiate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initiate value)? initiate,
    required TResult orElse(),
  }) {
    if (initiate != null) {
      return initiate(this);
    }
    return orElse();
  }
}

abstract class _Initiate implements PaymentState {
  const factory _Initiate(
      {final String? orderId,
      final String? key,
      final String? amount,
      final String? razorpayKey,
      final String? name,
      final String? description,
      final RazorpayOrderModel? razorpayModel}) = _$InitiateImpl;

  @override
  String? get orderId;
  @override
  String? get key;
  @override
  String? get amount;
  @override
  String? get razorpayKey;
  @override
  String? get name;
  @override
  String? get description;
  @override
  RazorpayOrderModel? get razorpayModel;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateImplCopyWith<_$InitiateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
