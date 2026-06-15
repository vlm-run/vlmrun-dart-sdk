// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fine_tuning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinetuningResponse _$FinetuningResponseFromJson(Map<String, dynamic> json) =>
    FinetuningResponse(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      completedAt: json['completed_at'] as String?,
      status: json['status'] as String,
      message: json['message'] as String,
      model: json['model'] as String,
      suffix: json['suffix'] as String?,
      wandbUrl: json['wandb_url'] as String?,
      wandbBaseUrl: json['wandb_base_url'] as String?,
      wandbProjectName: json['wandb_project_name'] as String?,
      usage: json['usage'] == null
          ? null
          : CreditUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinetuningResponseToJson(FinetuningResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_at': instance.createdAt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('completed_at', instance.completedAt);
  val['status'] = instance.status;
  val['message'] = instance.message;
  val['model'] = instance.model;
  writeNotNull('suffix', instance.suffix);
  writeNotNull('wandb_url', instance.wandbUrl);
  writeNotNull('wandb_base_url', instance.wandbBaseUrl);
  writeNotNull('wandb_project_name', instance.wandbProjectName);
  writeNotNull('usage', instance.usage?.toJson());
  return val;
}

FinetuningProvisionResponse _$FinetuningProvisionResponseFromJson(
        Map<String, dynamic> json) =>
    FinetuningProvisionResponse(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      completedAt: json['completed_at'] as String?,
      model: json['model'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$FinetuningProvisionResponseToJson(
    FinetuningProvisionResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_at': instance.createdAt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('completed_at', instance.completedAt);
  val['model'] = instance.model;
  val['message'] = instance.message;
  return val;
}
