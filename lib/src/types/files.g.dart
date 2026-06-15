// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileRequest _$FileRequestFromJson(Map<String, dynamic> json) => FileRequest(
      file: json['file'] as String,
      purpose: json['purpose'] as String?,
    );

Map<String, dynamic> _$FileRequestToJson(FileRequest instance) {
  final val = <String, dynamic>{
    'file': instance.file,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('purpose', instance.purpose);
  return val;
}

FileResponse _$FileResponseFromJson(Map<String, dynamic> json) => FileResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      bytes: json['bytes'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      filename: json['filename'] as String,
      purpose: json['purpose'] as String,
      publicUrl: json['public_url'] as String?,
    );

Map<String, dynamic> _$FileResponseToJson(FileResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'object': instance.object,
    'bytes': instance.bytes,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['filename'] = instance.filename;
  val['purpose'] = instance.purpose;
  writeNotNull('public_url', instance.publicUrl);
  return val;
}

FileListRequest _$FileListRequestFromJson(Map<String, dynamic> json) =>
    FileListRequest(
      purpose: json['purpose'] as String?,
      limit: json['limit'] as int?,
      after: json['after'] as String?,
      order: json['order'] as String?,
    );

Map<String, dynamic> _$FileListRequestToJson(FileListRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('purpose', instance.purpose);
  writeNotNull('limit', instance.limit);
  writeNotNull('after', instance.after);
  writeNotNull('order', instance.order);
  return val;
}
