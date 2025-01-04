// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_generate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentGenerateParams _$DocumentGenerateParamsFromJson(
        Map<String, dynamic> json) =>
    DocumentGenerateParams(
      id: json['id'] as String?,
      batch: json['batch'] as bool? ?? false,
      callbackUrl: json['callback_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      detail: json['detail'] as String? ?? 'auto',
      domain: json['domain'] as String?,
      fileId: json['file_id'] as String?,
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      metadata: json['metadata'] == null
          ? null
          : DocumentMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      model: json['model'] as String? ?? 'vlm-1',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$DocumentGenerateParamsToJson(
    DocumentGenerateParams instance) {
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
  val['detail'] = instance.detail;
  writeNotNull('domain', instance.domain);
  writeNotNull('file_id', instance.fileId);
  writeNotNull('json_schema', instance.jsonSchema);
  writeNotNull('metadata', instance.metadata?.toJson());
  val['model'] = instance.model;
  writeNotNull('url', instance.url);
  return val;
}

DocumentMetadata _$DocumentMetadataFromJson(Map<String, dynamic> json) =>
    DocumentMetadata(
      allowTraining: json['allow_training'] as bool? ?? false,
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$DocumentMetadataToJson(DocumentMetadata instance) {
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
