// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get useName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String useName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useName = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      useName: null == useName
          ? _value.useName
          : useName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String useName, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useName = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == useName
          ? _value.useName
          : useName // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.useName, this.password);

  @override
  final String useName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(useName: $useName, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.useName, useName) || other.useName == useName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, useName, password);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String useName, final String password) =
      _$LoginObjectImpl;

  @override
  String get useName;
  @override
  String get password;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConfigObject {
  String get mapWidth => throw _privateConstructorUsedError;
  String get mapLength => throw _privateConstructorUsedError;

  /// Create a copy of ConfigObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigObjectCopyWith<ConfigObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigObjectCopyWith<$Res> {
  factory $ConfigObjectCopyWith(
          ConfigObject value, $Res Function(ConfigObject) then) =
      _$ConfigObjectCopyWithImpl<$Res, ConfigObject>;
  @useResult
  $Res call({String mapWidth, String mapLength});
}

/// @nodoc
class _$ConfigObjectCopyWithImpl<$Res, $Val extends ConfigObject>
    implements $ConfigObjectCopyWith<$Res> {
  _$ConfigObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapWidth = null,
    Object? mapLength = null,
  }) {
    return _then(_value.copyWith(
      mapWidth: null == mapWidth
          ? _value.mapWidth
          : mapWidth // ignore: cast_nullable_to_non_nullable
              as String,
      mapLength: null == mapLength
          ? _value.mapLength
          : mapLength // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigObjectImplCopyWith<$Res>
    implements $ConfigObjectCopyWith<$Res> {
  factory _$$ConfigObjectImplCopyWith(
          _$ConfigObjectImpl value, $Res Function(_$ConfigObjectImpl) then) =
      __$$ConfigObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mapWidth, String mapLength});
}

/// @nodoc
class __$$ConfigObjectImplCopyWithImpl<$Res>
    extends _$ConfigObjectCopyWithImpl<$Res, _$ConfigObjectImpl>
    implements _$$ConfigObjectImplCopyWith<$Res> {
  __$$ConfigObjectImplCopyWithImpl(
      _$ConfigObjectImpl _value, $Res Function(_$ConfigObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfigObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapWidth = null,
    Object? mapLength = null,
  }) {
    return _then(_$ConfigObjectImpl(
      null == mapWidth
          ? _value.mapWidth
          : mapWidth // ignore: cast_nullable_to_non_nullable
              as String,
      null == mapLength
          ? _value.mapLength
          : mapLength // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConfigObjectImpl implements _ConfigObject {
  _$ConfigObjectImpl(this.mapWidth, this.mapLength);

  @override
  final String mapWidth;
  @override
  final String mapLength;

  @override
  String toString() {
    return 'ConfigObject(mapWidth: $mapWidth, mapLength: $mapLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigObjectImpl &&
            (identical(other.mapWidth, mapWidth) ||
                other.mapWidth == mapWidth) &&
            (identical(other.mapLength, mapLength) ||
                other.mapLength == mapLength));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mapWidth, mapLength);

  /// Create a copy of ConfigObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigObjectImplCopyWith<_$ConfigObjectImpl> get copyWith =>
      __$$ConfigObjectImplCopyWithImpl<_$ConfigObjectImpl>(this, _$identity);
}

abstract class _ConfigObject implements ConfigObject {
  factory _ConfigObject(final String mapWidth, final String mapLength) =
      _$ConfigObjectImpl;

  @override
  String get mapWidth;
  @override
  String get mapLength;

  /// Create a copy of ConfigObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigObjectImplCopyWith<_$ConfigObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeStateModel {
  bool get isFree => throw _privateConstructorUsedError;
  bool get isCharge => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;

  /// Create a copy of HomeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateModelCopyWith<HomeStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateModelCopyWith<$Res> {
  factory $HomeStateModelCopyWith(
          HomeStateModel value, $Res Function(HomeStateModel) then) =
      _$HomeStateModelCopyWithImpl<$Res, HomeStateModel>;
  @useResult
  $Res call({bool isFree, bool isCharge, bool isBlocked});
}

/// @nodoc
class _$HomeStateModelCopyWithImpl<$Res, $Val extends HomeStateModel>
    implements $HomeStateModelCopyWith<$Res> {
  _$HomeStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFree = null,
    Object? isCharge = null,
    Object? isBlocked = null,
  }) {
    return _then(_value.copyWith(
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      isCharge: null == isCharge
          ? _value.isCharge
          : isCharge // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateModelImplCopyWith<$Res>
    implements $HomeStateModelCopyWith<$Res> {
  factory _$$HomeStateModelImplCopyWith(_$HomeStateModelImpl value,
          $Res Function(_$HomeStateModelImpl) then) =
      __$$HomeStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFree, bool isCharge, bool isBlocked});
}

/// @nodoc
class __$$HomeStateModelImplCopyWithImpl<$Res>
    extends _$HomeStateModelCopyWithImpl<$Res, _$HomeStateModelImpl>
    implements _$$HomeStateModelImplCopyWith<$Res> {
  __$$HomeStateModelImplCopyWithImpl(
      _$HomeStateModelImpl _value, $Res Function(_$HomeStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFree = null,
    Object? isCharge = null,
    Object? isBlocked = null,
  }) {
    return _then(_$HomeStateModelImpl(
      null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isCharge
          ? _value.isCharge
          : isCharge // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeStateModelImpl implements _HomeStateModel {
  _$HomeStateModelImpl(this.isFree, this.isCharge, this.isBlocked);

  @override
  final bool isFree;
  @override
  final bool isCharge;
  @override
  final bool isBlocked;

  @override
  String toString() {
    return 'HomeStateModel(isFree: $isFree, isCharge: $isCharge, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateModelImpl &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.isCharge, isCharge) ||
                other.isCharge == isCharge) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFree, isCharge, isBlocked);

  /// Create a copy of HomeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateModelImplCopyWith<_$HomeStateModelImpl> get copyWith =>
      __$$HomeStateModelImplCopyWithImpl<_$HomeStateModelImpl>(
          this, _$identity);
}

abstract class _HomeStateModel implements HomeStateModel {
  factory _HomeStateModel(
          final bool isFree, final bool isCharge, final bool isBlocked) =
      _$HomeStateModelImpl;

  @override
  bool get isFree;
  @override
  bool get isCharge;
  @override
  bool get isBlocked;

  /// Create a copy of HomeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateModelImplCopyWith<_$HomeStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
