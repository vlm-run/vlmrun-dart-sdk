// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_generate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebGenerateParams _$WebGenerateParamsFromJson(Map<String, dynamic> json) =>
    WebGenerateParams(
      url: json['url'] as String,
      id: json['id'] as String?,
      callbackUrl: json['callback_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      domain: json['domain'] as String?,
      metadata: json['metadata'] == null
          ? null
          : WebMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      mode: json['mode'] as String? ?? 'fast',
      model: json['model'] as String? ?? 'vlm-1',
    );

Map<String, dynamic> _$WebGenerateParamsToJson(WebGenerateParams instance) {
  final val = <String, dynamic>{
    'url': instance.url,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('callback_url', instance.callbackUrl);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('domain', instance.domain);
  writeNotNull('metadata', instance.metadata?.toJson());
  val['mode'] = instance.mode;
  val['model'] = instance.model;
  return val;
}

WebMetadata _$WebMetadataFromJson(Map<String, dynamic> json) => WebMetadata(
      allowTraining: json['allow_training'] as bool? ?? false,
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$WebMetadataToJson(WebMetadata instance) {
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
