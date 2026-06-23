import 'package:json_annotation/json_annotation.dart';

part 'hub.g.dart';

/// Information about a supported domain.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class DomainInfo {
  /// Creates a [DomainInfo] instance.
  DomainInfo({
    required this.domain,
    required this.name,
    required this.description,
  });

  /// Domain identifier (e.g., `document.invoice`).
  final String domain;

  /// Human-readable domain name.
  final String name;

  /// Domain description.
  final String description;

  /// Deserializes from JSON.
  factory DomainInfo.fromJson(Map<String, dynamic> json) =>
      _$DomainInfoFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$DomainInfoToJson(this);
}

/// Hub version information.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class HubInfoResponse {
  /// Creates a [HubInfoResponse] instance.
  HubInfoResponse({
    required this.version,
  });

  /// Hub schema version.
  final String version;

  /// Deserializes from JSON.
  factory HubInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$HubInfoResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$HubInfoResponseToJson(this);
}

/// Schema information from the hub.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class HubSchemaResponse {
  /// Creates a [HubSchemaResponse] instance.
  HubSchemaResponse({
    required this.jsonSchema,
    required this.schemaVersion,
    required this.schemaHash,
    required this.domain,
    required this.gqlStmt,
    required this.description,
  });

  /// JSON Schema definition.
  final Map<String, dynamic> jsonSchema;

  /// Schema version.
  final String schemaVersion;

  /// SHA hash of the schema for deduplication.
  final String schemaHash;

  /// Domain this schema belongs to.
  final String domain;

  /// GraphQL statement for field selection.
  final String gqlStmt;

  /// Human-readable description.
  final String description;

  /// Deserializes from JSON.
  factory HubSchemaResponse.fromJson(Map<String, dynamic> json) =>
      _$HubSchemaResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$HubSchemaResponseToJson(this);
}

/// Schema response from the domains endpoint.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SchemaResponse {
  /// Creates a [SchemaResponse] instance.
  SchemaResponse({
    required this.jsonSchema,
    required this.schemaVersion,
    required this.schemaHash,
    required this.domain,
    required this.gqlStmt,
    required this.description,
  });

  /// JSON Schema definition.
  final Map<String, dynamic> jsonSchema;

  /// Schema version.
  final String schemaVersion;

  /// SHA hash of the schema.
  final String schemaHash;

  /// Domain this schema belongs to.
  final String domain;

  /// GraphQL statement for field selection.
  final String gqlStmt;

  /// Human-readable description.
  final String description;

  /// Deserializes from JSON.
  factory SchemaResponse.fromJson(Map<String, dynamic> json) =>
      _$SchemaResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$SchemaResponseToJson(this);
}
