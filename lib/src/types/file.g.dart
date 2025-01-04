// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreFileResponse _$StoreFileResponseFromJson(Map<String, dynamic> json) =>
    StoreFileResponse(
      bytes: (json['bytes'] as num).toInt(),
      filename: json['filename'] as String,
      purpose: json['purpose'] as String,
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      object: json['object'] as String? ?? 'file',
    );

Map<String, dynamic> _$StoreFileResponseToJson(StoreFileResponse instance) {
  final val = <String, dynamic>{
    'bytes': instance.bytes,
    'filename': instance.filename,
    'purpose': instance.purpose,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('object', instance.object);
  return val;
}
