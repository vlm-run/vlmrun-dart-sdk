// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGenerateParams _$ImageGenerateParamsFromJson(Map<String, dynamic> json) =>
    ImageGenerateParams(
      image: json['image'] as String,
      id: json['id'] as String?,
      callbackUrl: json['callback_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      detail: json['detail'] as String? ?? 'auto',
      domain: json['domain'] as String?,
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      metadata: json['metadata'] == null
          ? null
          : ImageMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      model: json['model'] as String? ?? 'vlm-1',
    );

Map<String, dynamic> _$ImageGenerateParamsToJson(ImageGenerateParams instance) {
  final val = <String, dynamic>{
    'image': instance.image,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('callback_url', instance.callbackUrl);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['detail'] = instance.detail;
  writeNotNull('domain', instance.domain);
  writeNotNull('json_schema', instance.jsonSchema);
  writeNotNull('metadata', instance.metadata?.toJson());
  val['model'] = instance.model;
  return val;
}

ImageMetadata _$ImageMetadataFromJson(Map<String, dynamic> json) =>
    ImageMetadata(
      allowTraining: json['allow_training'] as bool? ?? false,
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$ImageMetadataToJson(ImageMetadata instance) {
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
