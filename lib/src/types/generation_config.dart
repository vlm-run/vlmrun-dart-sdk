import 'package:json_annotation/json_annotation.dart';

import 'skill.dart';

part 'generation_config.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GenerationConfig {
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

  final String? prompt;
  final String detail;
  final Map<String, dynamic>? jsonSchema;
  final bool confidence;
  final bool grounding;
  final String? gqlStmt;
  final int maxRetries;
  final int maxTokens;
  final double temperature;
  final double? videoSegmentDuration;
  final int? videoFramesPerSegment;
  final List<int>? pageIndices;
  final String? serviceTier;
  final List<AgentSkill>? skills;

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationConfigToJson(this);
}
