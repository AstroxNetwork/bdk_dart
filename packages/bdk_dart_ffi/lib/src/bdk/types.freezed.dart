// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressIndex {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddressIndex);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddressIndex()';
  }
}

/// @nodoc
class $AddressIndexCopyWith<$Res> {
  $AddressIndexCopyWith(AddressIndex _, $Res Function(AddressIndex) __);
}

/// @nodoc

class AddressIndex_NewIndex extends AddressIndex {
  const AddressIndex_NewIndex() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddressIndex_NewIndex);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddressIndex.newIndex()';
  }
}

/// @nodoc

class AddressIndex_LastUnused extends AddressIndex {
  const AddressIndex_LastUnused() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddressIndex_LastUnused);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddressIndex.lastUnused()';
  }
}

/// @nodoc

class AddressIndex_Peek extends AddressIndex {
  const AddressIndex_Peek({required this.index}) : super._();

  final int index;

  /// Create a copy of AddressIndex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressIndex_PeekCopyWith<AddressIndex_Peek> get copyWith =>
      _$AddressIndex_PeekCopyWithImpl<AddressIndex_Peek>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddressIndex_Peek &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @override
  String toString() {
    return 'AddressIndex.peek(index: $index)';
  }
}

/// @nodoc
abstract mixin class $AddressIndex_PeekCopyWith<$Res>
    implements $AddressIndexCopyWith<$Res> {
  factory $AddressIndex_PeekCopyWith(
          AddressIndex_Peek value, $Res Function(AddressIndex_Peek) _then) =
      _$AddressIndex_PeekCopyWithImpl;
  @useResult
  $Res call({int index});
}

/// @nodoc
class _$AddressIndex_PeekCopyWithImpl<$Res>
    implements $AddressIndex_PeekCopyWith<$Res> {
  _$AddressIndex_PeekCopyWithImpl(this._self, this._then);

  final AddressIndex_Peek _self;
  final $Res Function(AddressIndex_Peek) _then;

  /// Create a copy of AddressIndex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
  }) {
    return _then(AddressIndex_Peek(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class AddressIndex_Reset extends AddressIndex {
  const AddressIndex_Reset({required this.index}) : super._();

  final int index;

  /// Create a copy of AddressIndex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressIndex_ResetCopyWith<AddressIndex_Reset> get copyWith =>
      _$AddressIndex_ResetCopyWithImpl<AddressIndex_Reset>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddressIndex_Reset &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @override
  String toString() {
    return 'AddressIndex.reset(index: $index)';
  }
}

/// @nodoc
abstract mixin class $AddressIndex_ResetCopyWith<$Res>
    implements $AddressIndexCopyWith<$Res> {
  factory $AddressIndex_ResetCopyWith(
          AddressIndex_Reset value, $Res Function(AddressIndex_Reset) _then) =
      _$AddressIndex_ResetCopyWithImpl;
  @useResult
  $Res call({int index});
}

/// @nodoc
class _$AddressIndex_ResetCopyWithImpl<$Res>
    implements $AddressIndex_ResetCopyWith<$Res> {
  _$AddressIndex_ResetCopyWithImpl(this._self, this._then);

  final AddressIndex_Reset _self;
  final $Res Function(AddressIndex_Reset) _then;

  /// Create a copy of AddressIndex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
  }) {
    return _then(AddressIndex_Reset(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Payload {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Payload);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Payload()';
  }
}

/// @nodoc
class $PayloadCopyWith<$Res> {
  $PayloadCopyWith(Payload _, $Res Function(Payload) __);
}

/// @nodoc

class Payload_PubkeyHash extends Payload {
  const Payload_PubkeyHash({required this.pubkeyHash}) : super._();

  final Uint8List pubkeyHash;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Payload_PubkeyHashCopyWith<Payload_PubkeyHash> get copyWith =>
      _$Payload_PubkeyHashCopyWithImpl<Payload_PubkeyHash>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Payload_PubkeyHash &&
            const DeepCollectionEquality()
                .equals(other.pubkeyHash, pubkeyHash));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pubkeyHash));

  @override
  String toString() {
    return 'Payload.pubkeyHash(pubkeyHash: $pubkeyHash)';
  }
}

/// @nodoc
abstract mixin class $Payload_PubkeyHashCopyWith<$Res>
    implements $PayloadCopyWith<$Res> {
  factory $Payload_PubkeyHashCopyWith(
          Payload_PubkeyHash value, $Res Function(Payload_PubkeyHash) _then) =
      _$Payload_PubkeyHashCopyWithImpl;
  @useResult
  $Res call({Uint8List pubkeyHash});
}

/// @nodoc
class _$Payload_PubkeyHashCopyWithImpl<$Res>
    implements $Payload_PubkeyHashCopyWith<$Res> {
  _$Payload_PubkeyHashCopyWithImpl(this._self, this._then);

  final Payload_PubkeyHash _self;
  final $Res Function(Payload_PubkeyHash) _then;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pubkeyHash = null,
  }) {
    return _then(Payload_PubkeyHash(
      pubkeyHash: null == pubkeyHash
          ? _self.pubkeyHash
          : pubkeyHash // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class Payload_ScriptHash extends Payload {
  const Payload_ScriptHash({required this.scriptHash}) : super._();

  final Uint8List scriptHash;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Payload_ScriptHashCopyWith<Payload_ScriptHash> get copyWith =>
      _$Payload_ScriptHashCopyWithImpl<Payload_ScriptHash>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Payload_ScriptHash &&
            const DeepCollectionEquality()
                .equals(other.scriptHash, scriptHash));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(scriptHash));

  @override
  String toString() {
    return 'Payload.scriptHash(scriptHash: $scriptHash)';
  }
}

/// @nodoc
abstract mixin class $Payload_ScriptHashCopyWith<$Res>
    implements $PayloadCopyWith<$Res> {
  factory $Payload_ScriptHashCopyWith(
          Payload_ScriptHash value, $Res Function(Payload_ScriptHash) _then) =
      _$Payload_ScriptHashCopyWithImpl;
  @useResult
  $Res call({Uint8List scriptHash});
}

/// @nodoc
class _$Payload_ScriptHashCopyWithImpl<$Res>
    implements $Payload_ScriptHashCopyWith<$Res> {
  _$Payload_ScriptHashCopyWithImpl(this._self, this._then);

  final Payload_ScriptHash _self;
  final $Res Function(Payload_ScriptHash) _then;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? scriptHash = null,
  }) {
    return _then(Payload_ScriptHash(
      scriptHash: null == scriptHash
          ? _self.scriptHash
          : scriptHash // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class Payload_WitnessProgram extends Payload {
  const Payload_WitnessProgram({required this.version, required this.program})
      : super._();

  /// The witness program version.
  final WitnessVersion version;

  /// The witness program.
  final Uint8List program;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Payload_WitnessProgramCopyWith<Payload_WitnessProgram> get copyWith =>
      _$Payload_WitnessProgramCopyWithImpl<Payload_WitnessProgram>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Payload_WitnessProgram &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other.program, program));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, version, const DeepCollectionEquality().hash(program));

  @override
  String toString() {
    return 'Payload.witnessProgram(version: $version, program: $program)';
  }
}

/// @nodoc
abstract mixin class $Payload_WitnessProgramCopyWith<$Res>
    implements $PayloadCopyWith<$Res> {
  factory $Payload_WitnessProgramCopyWith(Payload_WitnessProgram value,
          $Res Function(Payload_WitnessProgram) _then) =
      _$Payload_WitnessProgramCopyWithImpl;
  @useResult
  $Res call({WitnessVersion version, Uint8List program});
}

/// @nodoc
class _$Payload_WitnessProgramCopyWithImpl<$Res>
    implements $Payload_WitnessProgramCopyWith<$Res> {
  _$Payload_WitnessProgramCopyWithImpl(this._self, this._then);

  final Payload_WitnessProgram _self;
  final $Res Function(Payload_WitnessProgram) _then;

  /// Create a copy of Payload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
    Object? program = null,
  }) {
    return _then(Payload_WitnessProgram(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as WitnessVersion,
      program: null == program
          ? _self.program
          : program // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc
mixin _$RbfValue {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RbfValue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RbfValue()';
  }
}

/// @nodoc
class $RbfValueCopyWith<$Res> {
  $RbfValueCopyWith(RbfValue _, $Res Function(RbfValue) __);
}

/// @nodoc

class RbfValue_RbfDefault extends RbfValue {
  const RbfValue_RbfDefault() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RbfValue_RbfDefault);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RbfValue.rbfDefault()';
  }
}

/// @nodoc

class RbfValue_Value extends RbfValue {
  const RbfValue_Value(this.field0) : super._();

  final int field0;

  /// Create a copy of RbfValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RbfValue_ValueCopyWith<RbfValue_Value> get copyWith =>
      _$RbfValue_ValueCopyWithImpl<RbfValue_Value>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RbfValue_Value &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @override
  String toString() {
    return 'RbfValue.value(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $RbfValue_ValueCopyWith<$Res>
    implements $RbfValueCopyWith<$Res> {
  factory $RbfValue_ValueCopyWith(
          RbfValue_Value value, $Res Function(RbfValue_Value) _then) =
      _$RbfValue_ValueCopyWithImpl;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class _$RbfValue_ValueCopyWithImpl<$Res>
    implements $RbfValue_ValueCopyWith<$Res> {
  _$RbfValue_ValueCopyWithImpl(this._self, this._then);

  final RbfValue_Value _self;
  final $Res Function(RbfValue_Value) _then;

  /// Create a copy of RbfValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(RbfValue_Value(
      null == field0
          ? _self.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
