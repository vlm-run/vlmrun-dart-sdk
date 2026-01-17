// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMetadata _$RequestMetadataFromJson(Map<String, dynamic> json) =>
    RequestMetadata(
      environment: json['environment'] as String? ?? 'dev',
      sessionId: json['session_id'] as String?,
      allowTraining: json['allow_training'] as bool? ?? true,
    );

Map<String, dynamic> _$RequestMetadataToJson(RequestMetadata instance) {
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
