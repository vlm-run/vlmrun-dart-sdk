import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';
import 'skill.dart';

part 'agent.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentInfo {
  AgentInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.prompt,
    this.jsonSchema,
    this.jsonSample,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String id;
  final String name;
  final String description;
  final String prompt;
  final Map<String, dynamic>? jsonSchema;
  final Map<String, dynamic>? jsonSample;
  final String createdAt;
  final String updatedAt;
  final String status;

  factory AgentInfo.fromJson(Map<String, dynamic> json) =>
      _$AgentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AgentInfoToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentExecutionResponse {
  AgentExecutionResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    this.completedAt,
    this.response,
    required this.status,
    this.usage,
  });

  final String id;
  final String name;
  final String createdAt;
  final String? completedAt;
  final Map<String, dynamic>? response;
  final String status;
  final CreditUsage? usage;

  factory AgentExecutionResponse.fromJson(Map<String, dynamic> json) =>
      _$AgentExecutionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgentExecutionResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentCreationResponse {
  AgentCreationResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String status;

  factory AgentCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$AgentCreationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgentCreationResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentExecutionConfig {
  AgentExecutionConfig({
    this.prompt,
    this.jsonSchema,
    this.skills,
    this.serviceTier,
  });

  final String? prompt;
  final Map<String, dynamic>? jsonSchema;
  final List<AgentSkill>? skills;
  final String? serviceTier;

  factory AgentExecutionConfig.fromJson(Map<String, dynamic> json) =>
      _$AgentExecutionConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AgentExecutionConfigToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentCreationConfig {
  AgentCreationConfig({
    this.prompt,
    this.jsonSchema,
    this.skills,
    this.serviceTier,
  });

  final String? prompt;
  final Map<String, dynamic>? jsonSchema;
  final List<AgentSkill>? skills;
  final String? serviceTier;

  factory AgentCreationConfig.fromJson(Map<String, dynamic> json) =>
      _$AgentCreationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AgentCreationConfigToJson(this);
}
