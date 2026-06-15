// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) =>
    PredictionResponse(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      completedAt: json['completed_at'] as String?,
      response: json['response'] as Map<String, dynamic>?,
      status: json['status'] as String? ?? 'pending',
      message: json['message'] as String?,
      usage: json['usage'] == null
          ? null
          : CreditUsage.fromJson(json['usage'] as Map<String, dynamic>),
      domain: json['domain'] as String?,
    );

Map<String, dynamic> _$PredictionResponseToJson(PredictionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'completed_at': instance.completedAt,
      'response': instance.response,
      'status': instance.status,
      'message': instance.message,
      'usage': instance.usage?.toJson(),
      'domain': instance.domain,
    };
