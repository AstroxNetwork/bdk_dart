// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DatabaseConfig {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DatabaseConfig);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DatabaseConfig()';
  }
}

/// @nodoc
class $DatabaseConfigCopyWith<$Res> {
  $DatabaseConfigCopyWith(DatabaseConfig _, $Res Function(DatabaseConfig) __);
}

/// @nodoc

class DatabaseConfig_Memory extends DatabaseConfig {
  const DatabaseConfig_Memory() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DatabaseConfig_Memory);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DatabaseConfig.memory()';
  }
}

/// @nodoc

class DatabaseConfig_Sqlite extends DatabaseConfig {
  const DatabaseConfig_Sqlite({required this.config}) : super._();

  final SqliteDbConfiguration config;

  /// Create a copy of DatabaseConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatabaseConfig_SqliteCopyWith<DatabaseConfig_Sqlite> get copyWith =>
      _$DatabaseConfig_SqliteCopyWithImpl<DatabaseConfig_Sqlite>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatabaseConfig_Sqlite &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'DatabaseConfig.sqlite(config: $config)';
  }
}

/// @nodoc
abstract mixin class $DatabaseConfig_SqliteCopyWith<$Res>
    implements $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfig_SqliteCopyWith(DatabaseConfig_Sqlite value,
          $Res Function(DatabaseConfig_Sqlite) _then) =
      _$DatabaseConfig_SqliteCopyWithImpl;
  @useResult
  $Res call({SqliteDbConfiguration config});
}

/// @nodoc
class _$DatabaseConfig_SqliteCopyWithImpl<$Res>
    implements $DatabaseConfig_SqliteCopyWith<$Res> {
  _$DatabaseConfig_SqliteCopyWithImpl(this._self, this._then);

  final DatabaseConfig_Sqlite _self;
  final $Res Function(DatabaseConfig_Sqlite) _then;

  /// Create a copy of DatabaseConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(DatabaseConfig_Sqlite(
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as SqliteDbConfiguration,
    ));
  }
}

/// @nodoc

class DatabaseConfig_Sled extends DatabaseConfig {
  const DatabaseConfig_Sled({required this.config}) : super._();

  final SledDbConfiguration config;

  /// Create a copy of DatabaseConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatabaseConfig_SledCopyWith<DatabaseConfig_Sled> get copyWith =>
      _$DatabaseConfig_SledCopyWithImpl<DatabaseConfig_Sled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatabaseConfig_Sled &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'DatabaseConfig.sled(config: $config)';
  }
}

/// @nodoc
abstract mixin class $DatabaseConfig_SledCopyWith<$Res>
    implements $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfig_SledCopyWith(
          DatabaseConfig_Sled value, $Res Function(DatabaseConfig_Sled) _then) =
      _$DatabaseConfig_SledCopyWithImpl;
  @useResult
  $Res call({SledDbConfiguration config});
}

/// @nodoc
class _$DatabaseConfig_SledCopyWithImpl<$Res>
    implements $DatabaseConfig_SledCopyWith<$Res> {
  _$DatabaseConfig_SledCopyWithImpl(this._self, this._then);

  final DatabaseConfig_Sled _self;
  final $Res Function(DatabaseConfig_Sled) _then;

  /// Create a copy of DatabaseConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(DatabaseConfig_Sled(
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as SledDbConfiguration,
    ));
  }
}

// dart format on
