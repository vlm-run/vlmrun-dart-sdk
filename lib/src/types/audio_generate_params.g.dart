// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_generate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioGenerateParams _$AudioGenerateParamsFromJson(Map<String, dynamic> json) =>
    AudioGenerateParams(
      id: json['id'] as String?,
      batch: json['batch'] as bool? ?? false,
      callbackUrl: json['callback_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      domain: json['domain'] as String? ?? 'audio.transcription',
      fileId: json['file_id'] as String?,
      metadata: json['metadata'] == null
          ? null
          : AudioMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      model: json['model'] as String? ?? 'vlm-1',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AudioGenerateParamsToJson(AudioGenerateParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['batch'] = instance.batch;
  writeNotNull('callback_url', instance.callbackUrl);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['domain'] = instance.domain;
  writeNotNull('file_id', instance.fileId);
  writeNotNull('metadata', instance.metadata?.toJson());
  val['model'] = instance.model;
  writeNotNull('url', instance.url);
  return val;
}

AudioMetadata _$AudioMetadataFromJson(Map<String, dynamic> json) =>
    AudioMetadata(
      allowTraining: json['allow_training'] as bool? ?? false,
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$AudioMetadataToJson(AudioMetadata instance) {
  final val = <String, dynamic>{
    'allow_training': instance.allowTraining,
    'environment': instance.environment,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('session_id', instance.sessionId);
  return val;
}
