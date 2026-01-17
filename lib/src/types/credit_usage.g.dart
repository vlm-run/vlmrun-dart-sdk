// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditUsage _$CreditUsageFromJson(Map<String, dynamic> json) => CreditUsage(
      elementsProcessed: json['elements_processed'] as int?,
      elementType: json['element_type'] as String?,
      creditsUsed: json['credits_used'] as int?,
    );

Map<String, dynamic> _$CreditUsageToJson(CreditUsage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('elements_processed', instance.elementsProcessed);
  writeNotNull('element_type', instance.elementType);
  writeNotNull('credits_used', instance.creditsUsed);
  return val;
}
