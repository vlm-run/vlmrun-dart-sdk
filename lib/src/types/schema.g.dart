// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) =>
    PredictionResponse(
      prediction: json['prediction'],
      error: json['error'] as String?,
    );

Map<String, dynamic> _$PredictionResponseToJson(PredictionResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prediction', instance.prediction);
  writeNotNull('error', instance.error);
  return val;
}
