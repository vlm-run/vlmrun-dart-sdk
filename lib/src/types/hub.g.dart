// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DomainInfo _$DomainInfoFromJson(Map<String, dynamic> json) => DomainInfo(
      domain: json['domain'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$DomainInfoToJson(DomainInfo instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'name': instance.name,
      'description': instance.description,
    };

HubInfoResponse _$HubInfoResponseFromJson(Map<String, dynamic> json) =>
    HubInfoResponse(
      version: json['version'] as String,
    );

Map<String, dynamic> _$HubInfoResponseToJson(HubInfoResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

HubSchemaResponse _$HubSchemaResponseFromJson(Map<String, dynamic> json) =>
    HubSchemaResponse(
      jsonSchema: json['json_schema'] as Map<String, dynamic>,
      schemaVersion: json['schema_version'] as String,
      schemaHash: json['schema_hash'] as String,
      domain: json['domain'] as String,
      gqlStmt: json['gql_stmt'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$HubSchemaResponseToJson(HubSchemaResponse instance) =>
    <String, dynamic>{
      'json_schema': instance.jsonSchema,
      'schema_version': instance.schemaVersion,
      'schema_hash': instance.schemaHash,
      'domain': instance.domain,
      'gql_stmt': instance.gqlStmt,
      'description': instance.description,
    };

SchemaResponse _$SchemaResponseFromJson(Map<String, dynamic> json) =>
    SchemaResponse(
      jsonSchema: json['json_schema'] as Map<String, dynamic>,
      schemaVersion: json['schema_version'] as String,
      schemaHash: json['schema_hash'] as String,
      domain: json['domain'] as String,
      gqlStmt: json['gql_stmt'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SchemaResponseToJson(SchemaResponse instance) =>
    <String, dynamic>{
      'json_schema': instance.jsonSchema,
      'schema_version': instance.schemaVersion,
      'schema_hash': instance.schemaHash,
      'domain': instance.domain,
      'gql_stmt': instance.gqlStmt,
      'description': instance.description,
    };
