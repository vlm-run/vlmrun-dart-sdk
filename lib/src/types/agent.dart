import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';
import 'skill.dart';

part 'agent.g.dart';

/// Information about a registered agent.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentInfo {
  /// Creates an [AgentInfo] instance.
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

  /// Unique agent identifier.
  final String id;

  /// Agent name.
  final String name;

  /// Human-readable description of the agent.
  final String description;

  /// System prompt for the agent.
  final String prompt;

  /// Optional JSON schema for structured output.
  final Map<String, dynamic>? jsonSchema;

  /// Optional sample JSON response.
  final Map<String, dynamic>? jsonSample;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 last-updated timestamp.
  final String updatedAt;

  /// Current status (e.g., `active`).
  final String status;

  /// Deserializes from JSON.
  factory AgentInfo.fromJson(Map<String, dynamic> json) =>
      _$AgentInfoFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentInfoToJson(this);
}

/// Response from an agent execution.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentExecutionResponse {
  /// Creates an [AgentExecutionResponse] instance.
  AgentExecutionResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    this.completedAt,
    this.response,
    required this.status,
    this.usage,
  });

  /// Unique execution identifier.
  final String id;

  /// Agent name.
  final String name;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 completion timestamp, if finished.
  final String? completedAt;

  /// Structured response payload from the agent.
  final Map<String, dynamic>? response;

  /// Execution status (e.g., `pending`, `completed`).
  final String status;

  /// Credit usage for this execution.
  final CreditUsage? usage;

  /// Deserializes from JSON.
  factory AgentExecutionResponse.fromJson(Map<String, dynamic> json) =>
      _$AgentExecutionResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentExecutionResponseToJson(this);
}

/// Response from creating a new agent.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentCreationResponse {
  /// Creates an [AgentCreationResponse] instance.
  AgentCreationResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  /// Unique agent identifier.
  final String id;

  /// Agent name.
  final String name;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 last-updated timestamp.
  final String updatedAt;

  /// Current status.
  final String status;

  /// Deserializes from JSON.
  factory AgentCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$AgentCreationResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentCreationResponseToJson(this);
}

/// Configuration for agent execution.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentExecutionConfig {
  /// Creates an [AgentExecutionConfig] instance.
  AgentExecutionConfig({
    this.prompt,
    this.jsonSchema,
    this.skills,
    this.serviceTier,
  });

  /// Optional prompt override for this execution.
  final String? prompt;

  /// Optional JSON schema for structured output.
  final Map<String, dynamic>? jsonSchema;

  /// Skills to attach to this execution.
  final List<AgentSkill>? skills;

  /// Service tier (`standard`, `flex`, or `priority`).
  final String? serviceTier;

  /// Deserializes from JSON.
  factory AgentExecutionConfig.fromJson(Map<String, dynamic> json) =>
      _$AgentExecutionConfigFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentExecutionConfigToJson(this);
}

/// Configuration for agent creation.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentCreationConfig {
  /// Creates an [AgentCreationConfig] instance.
  AgentCreationConfig({
    this.prompt,
    this.jsonSchema,
    this.skills,
    this.serviceTier,
  });

  /// System prompt for the agent.
  final String? prompt;

  /// JSON schema for structured output.
  final Map<String, dynamic>? jsonSchema;

  /// Skills to attach to the agent.
  final List<AgentSkill>? skills;

  /// Service tier (`standard`, `flex`, or `priority`).
  final String? serviceTier;

  /// Deserializes from JSON.
  factory AgentCreationConfig.fromJson(Map<String, dynamic> json) =>
      _$AgentCreationConfigFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentCreationConfigToJson(this);
}
