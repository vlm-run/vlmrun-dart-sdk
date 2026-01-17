// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_generate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoMetadata _$VideoMetadataFromJson(Map<String, dynamic> json) =>
    VideoMetadata(
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
      allowTraining: json['allow_training'] as bool? ?? true,
    );

Map<String, dynamic> _$VideoMetadataToJson(VideoMetadata instance) {
  final val = <String, dynamic>{
    'environment': instance.environment,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('session_id', instance.sessionId);
  val['allow_training'] = instance.allowTraining;
  return val;
}

VideoGenerateParams _$VideoGenerateParamsFromJson(Map<String, dynamic> json) =>
    VideoGenerateParams(
      id: json['id'] as String?,
      batch: json['batch'] as bool? ?? false,
      callbackUrl: json['callback_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      domain: json['domain'] as String?,
      fileId: json['file_id'] as String?,
      metadata: json['metadata'] == null
          ? null
          : VideoMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      model: json['model'] as String? ?? 'vlm-1',
      url: json['url'] as String?,
      config: json['config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$VideoGenerateParamsToJson(VideoGenerateParams instance) {
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
  writeNotNull('domain', instance.domain);
  writeNotNull('file_id', instance.fileId);
  writeNotNull('metadata', instance.metadata?.toJson());
  val['model'] = instance.model;
  writeNotNull('url', instance.url);
  writeNotNull('config', instance.config);
  return val;
}
