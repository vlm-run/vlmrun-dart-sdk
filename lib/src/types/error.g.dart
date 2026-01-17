// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VlmError _$VlmErrorFromJson(Map<String, dynamic> json) => VlmError(
      statusCode: json['statusCode'] as int,
      details: json['details'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VlmErrorToJson(VlmError instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'details': instance.details,
    };
