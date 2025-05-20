// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bdk_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BdkException {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BdkException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException()';
  }
}

/// @nodoc
class $BdkExceptionCopyWith<$Res> {
  $BdkExceptionCopyWith(BdkException _, $Res Function(BdkException) __);
}

/// @nodoc

class BdkExceptionScriptDoesntHaveAddressForm implements BdkException {
  const BdkExceptionScriptDoesntHaveAddressForm();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionScriptDoesntHaveAddressForm);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.scriptDoesntHaveAddressForm()';
  }
}

/// @nodoc

class BdkExceptionNoRecipients implements BdkException {
  const BdkExceptionNoRecipients();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BdkExceptionNoRecipients);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.noRecipients()';
  }
}

/// @nodoc

class BdkExceptionGeneric implements BdkException {
  const BdkExceptionGeneric(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionGenericCopyWith<BdkExceptionGeneric> get copyWith =>
      _$BdkExceptionGenericCopyWithImpl<BdkExceptionGeneric>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionGeneric &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.generic(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionGenericCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionGenericCopyWith(
          BdkExceptionGeneric value, $Res Function(BdkExceptionGeneric) _then) =
      _$BdkExceptionGenericCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionGenericCopyWithImpl<$Res>
    implements $BdkExceptionGenericCopyWith<$Res> {
  _$BdkExceptionGenericCopyWithImpl(this._self, this._then);

  final BdkExceptionGeneric _self;
  final $Res Function(BdkExceptionGeneric) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionGeneric(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionNoUtxosSelected implements BdkException {
  const BdkExceptionNoUtxosSelected();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionNoUtxosSelected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.noUtxosSelected()';
  }
}

/// @nodoc

class BdkExceptionOutputBelowDustLimit implements BdkException {
  const BdkExceptionOutputBelowDustLimit();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionOutputBelowDustLimit);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.outputBelowDustLimit()';
  }
}

/// @nodoc

class BdkExceptionInsufficientFunds implements BdkException {
  const BdkExceptionInsufficientFunds(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionInsufficientFundsCopyWith<BdkExceptionInsufficientFunds>
      get copyWith => _$BdkExceptionInsufficientFundsCopyWithImpl<
          BdkExceptionInsufficientFunds>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionInsufficientFunds &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.insufficientFunds(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionInsufficientFundsCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionInsufficientFundsCopyWith(
          BdkExceptionInsufficientFunds value,
          $Res Function(BdkExceptionInsufficientFunds) _then) =
      _$BdkExceptionInsufficientFundsCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionInsufficientFundsCopyWithImpl<$Res>
    implements $BdkExceptionInsufficientFundsCopyWith<$Res> {
  _$BdkExceptionInsufficientFundsCopyWithImpl(this._self, this._then);

  final BdkExceptionInsufficientFunds _self;
  final $Res Function(BdkExceptionInsufficientFunds) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionInsufficientFunds(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionBnBTotalTriesExceeded implements BdkException {
  const BdkExceptionBnBTotalTriesExceeded();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionBnBTotalTriesExceeded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.bnBTotalTriesExceeded()';
  }
}

/// @nodoc

class BdkExceptionBnBNoExactMatch implements BdkException {
  const BdkExceptionBnBNoExactMatch();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionBnBNoExactMatch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.bnBNoExactMatch()';
  }
}

/// @nodoc

class BdkExceptionUnknownUtxo implements BdkException {
  const BdkExceptionUnknownUtxo();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BdkExceptionUnknownUtxo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.unknownUtxo()';
  }
}

/// @nodoc

class BdkExceptionTransactionNotFound implements BdkException {
  const BdkExceptionTransactionNotFound();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionTransactionNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.transactionNotFound()';
  }
}

/// @nodoc

class BdkExceptionTransactionConfirmed implements BdkException {
  const BdkExceptionTransactionConfirmed();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionTransactionConfirmed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.transactionConfirmed()';
  }
}

/// @nodoc

class BdkExceptionFeeRateTooLow implements BdkException {
  const BdkExceptionFeeRateTooLow(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionFeeRateTooLowCopyWith<BdkExceptionFeeRateTooLow> get copyWith =>
      _$BdkExceptionFeeRateTooLowCopyWithImpl<BdkExceptionFeeRateTooLow>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionFeeRateTooLow &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.feeRateTooLow(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionFeeRateTooLowCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionFeeRateTooLowCopyWith(BdkExceptionFeeRateTooLow value,
          $Res Function(BdkExceptionFeeRateTooLow) _then) =
      _$BdkExceptionFeeRateTooLowCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionFeeRateTooLowCopyWithImpl<$Res>
    implements $BdkExceptionFeeRateTooLowCopyWith<$Res> {
  _$BdkExceptionFeeRateTooLowCopyWithImpl(this._self, this._then);

  final BdkExceptionFeeRateTooLow _self;
  final $Res Function(BdkExceptionFeeRateTooLow) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionFeeRateTooLow(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionFeeTooLow implements BdkException {
  const BdkExceptionFeeTooLow(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionFeeTooLowCopyWith<BdkExceptionFeeTooLow> get copyWith =>
      _$BdkExceptionFeeTooLowCopyWithImpl<BdkExceptionFeeTooLow>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionFeeTooLow &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.feeTooLow(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionFeeTooLowCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionFeeTooLowCopyWith(BdkExceptionFeeTooLow value,
          $Res Function(BdkExceptionFeeTooLow) _then) =
      _$BdkExceptionFeeTooLowCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionFeeTooLowCopyWithImpl<$Res>
    implements $BdkExceptionFeeTooLowCopyWith<$Res> {
  _$BdkExceptionFeeTooLowCopyWithImpl(this._self, this._then);

  final BdkExceptionFeeTooLow _self;
  final $Res Function(BdkExceptionFeeTooLow) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionFeeTooLow(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionFeeRateUnavailable implements BdkException {
  const BdkExceptionFeeRateUnavailable();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionFeeRateUnavailable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.feeRateUnavailable()';
  }
}

/// @nodoc

class BdkExceptionChecksumMismatch implements BdkException {
  const BdkExceptionChecksumMismatch();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionChecksumMismatch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.checksumMismatch()';
  }
}

/// @nodoc

class BdkExceptionMiniscript implements BdkException {
  const BdkExceptionMiniscript(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionMiniscriptCopyWith<BdkExceptionMiniscript> get copyWith =>
      _$BdkExceptionMiniscriptCopyWithImpl<BdkExceptionMiniscript>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionMiniscript &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.miniscript(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionMiniscriptCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionMiniscriptCopyWith(BdkExceptionMiniscript value,
          $Res Function(BdkExceptionMiniscript) _then) =
      _$BdkExceptionMiniscriptCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionMiniscriptCopyWithImpl<$Res>
    implements $BdkExceptionMiniscriptCopyWith<$Res> {
  _$BdkExceptionMiniscriptCopyWithImpl(this._self, this._then);

  final BdkExceptionMiniscript _self;
  final $Res Function(BdkExceptionMiniscript) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionMiniscript(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionBip32 implements BdkException {
  const BdkExceptionBip32(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionBip32CopyWith<BdkExceptionBip32> get copyWith =>
      _$BdkExceptionBip32CopyWithImpl<BdkExceptionBip32>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionBip32 &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.bip32(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionBip32CopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionBip32CopyWith(
          BdkExceptionBip32 value, $Res Function(BdkExceptionBip32) _then) =
      _$BdkExceptionBip32CopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionBip32CopyWithImpl<$Res>
    implements $BdkExceptionBip32CopyWith<$Res> {
  _$BdkExceptionBip32CopyWithImpl(this._self, this._then);

  final BdkExceptionBip32 _self;
  final $Res Function(BdkExceptionBip32) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionBip32(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionSecp256k1 implements BdkException {
  const BdkExceptionSecp256k1(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionSecp256k1CopyWith<BdkExceptionSecp256k1> get copyWith =>
      _$BdkExceptionSecp256k1CopyWithImpl<BdkExceptionSecp256k1>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionSecp256k1 &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.secp256k1(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionSecp256k1CopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionSecp256k1CopyWith(BdkExceptionSecp256k1 value,
          $Res Function(BdkExceptionSecp256k1) _then) =
      _$BdkExceptionSecp256k1CopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionSecp256k1CopyWithImpl<$Res>
    implements $BdkExceptionSecp256k1CopyWith<$Res> {
  _$BdkExceptionSecp256k1CopyWithImpl(this._self, this._then);

  final BdkExceptionSecp256k1 _self;
  final $Res Function(BdkExceptionSecp256k1) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionSecp256k1(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionMissingCachedScripts implements BdkException {
  const BdkExceptionMissingCachedScripts();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionMissingCachedScripts);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BdkException.missingCachedScripts()';
  }
}

/// @nodoc

class BdkExceptionElectrum implements BdkException {
  const BdkExceptionElectrum(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionElectrumCopyWith<BdkExceptionElectrum> get copyWith =>
      _$BdkExceptionElectrumCopyWithImpl<BdkExceptionElectrum>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionElectrum &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.electrum(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionElectrumCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionElectrumCopyWith(BdkExceptionElectrum value,
          $Res Function(BdkExceptionElectrum) _then) =
      _$BdkExceptionElectrumCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionElectrumCopyWithImpl<$Res>
    implements $BdkExceptionElectrumCopyWith<$Res> {
  _$BdkExceptionElectrumCopyWithImpl(this._self, this._then);

  final BdkExceptionElectrum _self;
  final $Res Function(BdkExceptionElectrum) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionElectrum(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionEsplora implements BdkException {
  const BdkExceptionEsplora(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionEsploraCopyWith<BdkExceptionEsplora> get copyWith =>
      _$BdkExceptionEsploraCopyWithImpl<BdkExceptionEsplora>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionEsplora &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.esplora(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionEsploraCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionEsploraCopyWith(
          BdkExceptionEsplora value, $Res Function(BdkExceptionEsplora) _then) =
      _$BdkExceptionEsploraCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionEsploraCopyWithImpl<$Res>
    implements $BdkExceptionEsploraCopyWith<$Res> {
  _$BdkExceptionEsploraCopyWithImpl(this._self, this._then);

  final BdkExceptionEsplora _self;
  final $Res Function(BdkExceptionEsplora) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionEsplora(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionSled implements BdkException {
  const BdkExceptionSled(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionSledCopyWith<BdkExceptionSled> get copyWith =>
      _$BdkExceptionSledCopyWithImpl<BdkExceptionSled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionSled &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.sled(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionSledCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionSledCopyWith(
          BdkExceptionSled value, $Res Function(BdkExceptionSled) _then) =
      _$BdkExceptionSledCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionSledCopyWithImpl<$Res>
    implements $BdkExceptionSledCopyWith<$Res> {
  _$BdkExceptionSledCopyWithImpl(this._self, this._then);

  final BdkExceptionSled _self;
  final $Res Function(BdkExceptionSled) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionSled(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionDescriptor implements BdkException {
  const BdkExceptionDescriptor(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionDescriptorCopyWith<BdkExceptionDescriptor> get copyWith =>
      _$BdkExceptionDescriptorCopyWithImpl<BdkExceptionDescriptor>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionDescriptor &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.descriptor(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionDescriptorCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionDescriptorCopyWith(BdkExceptionDescriptor value,
          $Res Function(BdkExceptionDescriptor) _then) =
      _$BdkExceptionDescriptorCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionDescriptorCopyWithImpl<$Res>
    implements $BdkExceptionDescriptorCopyWith<$Res> {
  _$BdkExceptionDescriptorCopyWithImpl(this._self, this._then);

  final BdkExceptionDescriptor _self;
  final $Res Function(BdkExceptionDescriptor) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionDescriptor(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionRpc implements BdkException {
  const BdkExceptionRpc(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionRpcCopyWith<BdkExceptionRpc> get copyWith =>
      _$BdkExceptionRpcCopyWithImpl<BdkExceptionRpc>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionRpc &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.rpc(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionRpcCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionRpcCopyWith(
          BdkExceptionRpc value, $Res Function(BdkExceptionRpc) _then) =
      _$BdkExceptionRpcCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionRpcCopyWithImpl<$Res>
    implements $BdkExceptionRpcCopyWith<$Res> {
  _$BdkExceptionRpcCopyWithImpl(this._self, this._then);

  final BdkExceptionRpc _self;
  final $Res Function(BdkExceptionRpc) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionRpc(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionRusqlite implements BdkException {
  const BdkExceptionRusqlite(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionRusqliteCopyWith<BdkExceptionRusqlite> get copyWith =>
      _$BdkExceptionRusqliteCopyWithImpl<BdkExceptionRusqlite>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionRusqlite &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.rusqlite(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionRusqliteCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionRusqliteCopyWith(BdkExceptionRusqlite value,
          $Res Function(BdkExceptionRusqlite) _then) =
      _$BdkExceptionRusqliteCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionRusqliteCopyWithImpl<$Res>
    implements $BdkExceptionRusqliteCopyWith<$Res> {
  _$BdkExceptionRusqliteCopyWithImpl(this._self, this._then);

  final BdkExceptionRusqlite _self;
  final $Res Function(BdkExceptionRusqlite) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionRusqlite(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BdkExceptionUnexpected implements BdkException {
  const BdkExceptionUnexpected(this.e);

  final String e;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BdkExceptionUnexpectedCopyWith<BdkExceptionUnexpected> get copyWith =>
      _$BdkExceptionUnexpectedCopyWithImpl<BdkExceptionUnexpected>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BdkExceptionUnexpected &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @override
  String toString() {
    return 'BdkException.unexpected(e: $e)';
  }
}

/// @nodoc
abstract mixin class $BdkExceptionUnexpectedCopyWith<$Res>
    implements $BdkExceptionCopyWith<$Res> {
  factory $BdkExceptionUnexpectedCopyWith(BdkExceptionUnexpected value,
          $Res Function(BdkExceptionUnexpected) _then) =
      _$BdkExceptionUnexpectedCopyWithImpl;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$BdkExceptionUnexpectedCopyWithImpl<$Res>
    implements $BdkExceptionUnexpectedCopyWith<$Res> {
  _$BdkExceptionUnexpectedCopyWithImpl(this._self, this._then);

  final BdkExceptionUnexpected _self;
  final $Res Function(BdkExceptionUnexpected) _then;

  /// Create a copy of BdkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = null,
  }) {
    return _then(BdkExceptionUnexpected(
      null == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
