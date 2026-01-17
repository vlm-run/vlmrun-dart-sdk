// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerationConfig _$GenerationConfigFromJson(Map<String, dynamic> json) =>
    GenerationConfig(
      detail: json['detail'] as String? ?? 'auto',
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      confidence: json['confidence'] as bool? ?? false,
      grounding: json['grounding'] as bool? ?? false,
      gqlStmt: json['gql_stmt'] as String?,
    );

Map<String, dynamic> _$GenerationConfigToJson(GenerationConfig instance) {
  final val = <String, dynamic>{
    'detail': instance.detail,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('json_schema', instance.jsonSchema);
  val['confidence'] = instance.confidence;
  val['grounding'] = instance.grounding;
  writeNotNull('gql_stmt', instance.gqlStmt);
  return val;
}
