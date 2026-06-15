// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatasetResponse _$DatasetResponseFromJson(Map<String, dynamic> json) =>
    DatasetResponse(
      id: json['id'] as String,
      datasetType: json['dataset_type'] as String,
      datasetName: json['dataset_name'] as String,
      domain: json['domain'] as String,
      fileId: json['file_id'] as String?,
      message: json['message'] as String?,
      wandbBaseUrl: json['wandb_base_url'] as String?,
      wandbProjectName: json['wandb_project_name'] as String?,
      wandbUrl: json['wandb_url'] as String?,
      createdAt: json['created_at'] as String,
      completedAt: json['completed_at'] as String?,
      status: json['status'] as String,
      usage: json['usage'] == null
          ? null
          : CreditUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatasetResponseToJson(DatasetResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'dataset_type': instance.datasetType,
    'dataset_name': instance.datasetName,
    'domain': instance.domain,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('file_id', instance.fileId);
  writeNotNull('message', instance.message);
  writeNotNull('wandb_base_url', instance.wandbBaseUrl);
  writeNotNull('wandb_project_name', instance.wandbProjectName);
  writeNotNull('wandb_url', instance.wandbUrl);
  val['created_at'] = instance.createdAt;
  writeNotNull('completed_at', instance.completedAt);
  val['status'] = instance.status;
  writeNotNull('usage', instance.usage?.toJson());
  return val;
}
