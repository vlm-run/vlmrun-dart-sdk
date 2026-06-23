import 'package:json_annotation/json_annotation.dart';

import 'skill.dart';

part 'generation_config.g.dart';

/// Configuration for prediction generation.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GenerationConfig {
  /// Creates a [GenerationConfig] instance.
  GenerationConfig({
    this.prompt,
    this.detail = 'auto',
    this.jsonSchema,
    this.confidence = false,
    this.grounding = false,
    this.gqlStmt,
    this.maxRetries = 3,
    this.maxTokens = 65535,
    this.temperature = 0.0,
    this.videoSegmentDuration,
    this.videoFramesPerSegment,
    this.pageIndices,
    this.serviceTier,
    this.skills,
  });

  /// Optional prompt to guide extraction.
  final String? prompt;

  /// Detail level for image processing (`auto`, `low`, `high`).
  final String detail;

  /// JSON schema to constrain structured output.
  final Map<String, dynamic>? jsonSchema;

  /// Whether to include confidence scores in output.
  final bool confidence;

  /// Whether to include spatial grounding (bounding boxes).
  final bool grounding;

  /// Optional GraphQL statement for field selection.
  final String? gqlStmt;

  /// Maximum retry attempts on failure.
  final int maxRetries;

  /// Maximum output tokens.
  final int maxTokens;

  /// Sampling temperature (0.0 = deterministic).
  final double temperature;

  /// Duration in seconds per video segment.
  final double? videoSegmentDuration;

  /// Number of frames to sample per video segment.
  final int? videoFramesPerSegment;

  /// Specific page indices to process (for documents).
  final List<int>? pageIndices;

  /// Service tier (`standard`, `flex`, or `priority`).
  final String? serviceTier;

  /// Skills to apply during generation.
  final List<AgentSkill>? skills;

  /// Deserializes from JSON.
  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$GenerationConfigToJson(this);
}
