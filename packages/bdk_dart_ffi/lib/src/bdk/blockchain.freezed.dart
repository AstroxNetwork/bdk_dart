// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blockchain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockchainConfig {
  Object get config;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlockchainConfig &&
            const DeepCollectionEquality().equals(other.config, config));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(config));

  @override
  String toString() {
    return 'BlockchainConfig(config: $config)';
  }
}

/// @nodoc
class $BlockchainConfigCopyWith<$Res> {
  $BlockchainConfigCopyWith(
      BlockchainConfig _, $Res Function(BlockchainConfig) __);
}

/// @nodoc

class BlockchainConfig_Electrum extends BlockchainConfig {
  const BlockchainConfig_Electrum({required this.config}) : super._();

  @override
  final ElectrumConfig config;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BlockchainConfig_ElectrumCopyWith<BlockchainConfig_Electrum> get copyWith =>
      _$BlockchainConfig_ElectrumCopyWithImpl<BlockchainConfig_Electrum>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlockchainConfig_Electrum &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'BlockchainConfig.electrum(config: $config)';
  }
}

/// @nodoc
abstract mixin class $BlockchainConfig_ElectrumCopyWith<$Res>
    implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_ElectrumCopyWith(BlockchainConfig_Electrum value,
          $Res Function(BlockchainConfig_Electrum) _then) =
      _$BlockchainConfig_ElectrumCopyWithImpl;
  @useResult
  $Res call({ElectrumConfig config});
}

/// @nodoc
class _$BlockchainConfig_ElectrumCopyWithImpl<$Res>
    implements $BlockchainConfig_ElectrumCopyWith<$Res> {
  _$BlockchainConfig_ElectrumCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Electrum _self;
  final $Res Function(BlockchainConfig_Electrum) _then;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(BlockchainConfig_Electrum(
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as ElectrumConfig,
    ));
  }
}

/// @nodoc

class BlockchainConfig_Esplora extends BlockchainConfig {
  const BlockchainConfig_Esplora({required this.config}) : super._();

  @override
  final EsploraConfig config;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BlockchainConfig_EsploraCopyWith<BlockchainConfig_Esplora> get copyWith =>
      _$BlockchainConfig_EsploraCopyWithImpl<BlockchainConfig_Esplora>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlockchainConfig_Esplora &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'BlockchainConfig.esplora(config: $config)';
  }
}

/// @nodoc
abstract mixin class $BlockchainConfig_EsploraCopyWith<$Res>
    implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_EsploraCopyWith(BlockchainConfig_Esplora value,
          $Res Function(BlockchainConfig_Esplora) _then) =
      _$BlockchainConfig_EsploraCopyWithImpl;
  @useResult
  $Res call({EsploraConfig config});
}

/// @nodoc
class _$BlockchainConfig_EsploraCopyWithImpl<$Res>
    implements $BlockchainConfig_EsploraCopyWith<$Res> {
  _$BlockchainConfig_EsploraCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Esplora _self;
  final $Res Function(BlockchainConfig_Esplora) _then;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(BlockchainConfig_Esplora(
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as EsploraConfig,
    ));
  }
}

/// @nodoc

class BlockchainConfig_Rpc extends BlockchainConfig {
  const BlockchainConfig_Rpc({required this.config}) : super._();

  @override
  final RpcConfig config;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BlockchainConfig_RpcCopyWith<BlockchainConfig_Rpc> get copyWith =>
      _$BlockchainConfig_RpcCopyWithImpl<BlockchainConfig_Rpc>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlockchainConfig_Rpc &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'BlockchainConfig.rpc(config: $config)';
  }
}

/// @nodoc
abstract mixin class $BlockchainConfig_RpcCopyWith<$Res>
    implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_RpcCopyWith(BlockchainConfig_Rpc value,
          $Res Function(BlockchainConfig_Rpc) _then) =
      _$BlockchainConfig_RpcCopyWithImpl;
  @useResult
  $Res call({RpcConfig config});
}

/// @nodoc
class _$BlockchainConfig_RpcCopyWithImpl<$Res>
    implements $BlockchainConfig_RpcCopyWith<$Res> {
  _$BlockchainConfig_RpcCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Rpc _self;
  final $Res Function(BlockchainConfig_Rpc) _then;

  /// Create a copy of BlockchainConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(BlockchainConfig_Rpc(
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as RpcConfig,
    ));
  }
}

// dart format on
