// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerationConfig _$GenerationConfigFromJson(Map<String, dynamic> json) =>
    GenerationConfig(
      prompt: json['prompt'] as String?,
      detail: json['detail'] as String? ?? 'auto',
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      confidence: json['confidence'] as bool? ?? false,
      grounding: json['grounding'] as bool? ?? false,
      gqlStmt: json['gql_stmt'] as String?,
      maxRetries: json['max_retries'] as int? ?? 3,
      maxTokens: json['max_tokens'] as int? ?? 65535,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      videoSegmentDuration:
          (json['video_segment_duration'] as num?)?.toDouble(),
      videoFramesPerSegment: json['video_frames_per_segment'] as int?,
      pageIndices: (json['page_indices'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      serviceTier: json['service_tier'] as String?,
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => AgentSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenerationConfigToJson(GenerationConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prompt', instance.prompt);
  val['detail'] = instance.detail;
  writeNotNull('json_schema', instance.jsonSchema);
  val['confidence'] = instance.confidence;
  val['grounding'] = instance.grounding;
  writeNotNull('gql_stmt', instance.gqlStmt);
  val['max_retries'] = instance.maxRetries;
  val['max_tokens'] = instance.maxTokens;
  val['temperature'] = instance.temperature;
  writeNotNull('video_segment_duration', instance.videoSegmentDuration);
  writeNotNull('video_frames_per_segment', instance.videoFramesPerSegment);
  writeNotNull('page_indices', instance.pageIndices);
  writeNotNull('service_tier', instance.serviceTier);
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  return val;
}
