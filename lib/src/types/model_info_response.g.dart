// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelInfoResponse _$ModelInfoResponseFromJson(Map<String, dynamic> json) =>
    ModelInfoResponse(
      domain: json['domain'] as String,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$ModelInfoResponseToJson(ModelInfoResponse instance) {
  final val = <String, dynamic>{
    'domain': instance.domain,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('model', instance.model);
  return val;
}
