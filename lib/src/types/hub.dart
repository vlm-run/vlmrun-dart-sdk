import 'package:json_annotation/json_annotation.dart';

part 'hub.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class DomainInfo {
  DomainInfo({
    required this.domain,
    required this.name,
    required this.description,
  });

  final String domain;
  final String name;
  final String description;

  factory DomainInfo.fromJson(Map<String, dynamic> json) =>
      _$DomainInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DomainInfoToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class HubInfoResponse {
  HubInfoResponse({
    required this.version,
  });

  final String version;

  factory HubInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$HubInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HubInfoResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class HubSchemaResponse {
  HubSchemaResponse({
    required this.jsonSchema,
    required this.schemaVersion,
    required this.schemaHash,
    required this.domain,
    required this.gqlStmt,
    required this.description,
  });

  final Map<String, dynamic> jsonSchema;
  final String schemaVersion;
  final String schemaHash;
  final String domain;
  final String gqlStmt;
  final String description;

  factory HubSchemaResponse.fromJson(Map<String, dynamic> json) =>
      _$HubSchemaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HubSchemaResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SchemaResponse {
  SchemaResponse({
    required this.jsonSchema,
    required this.schemaVersion,
    required this.schemaHash,
    required this.domain,
    required this.gqlStmt,
    required this.description,
  });

  final Map<String, dynamic> jsonSchema;
  final String schemaVersion;
  final String schemaHash;
  final String domain;
  final String gqlStmt;
  final String description;

  factory SchemaResponse.fromJson(Map<String, dynamic> json) =>
      _$SchemaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaResponseToJson(this);
}
