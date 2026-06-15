// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presigned_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresignedUrlRequest _$PresignedUrlRequestFromJson(Map<String, dynamic> json) =>
    PresignedUrlRequest(
      filename: json['filename'] as String,
      purpose: json['purpose'] as String?,
    );

Map<String, dynamic> _$PresignedUrlRequestToJson(PresignedUrlRequest instance) {
  final val = <String, dynamic>{
    'filename': instance.filename,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('purpose', instance.purpose);
  return val;
}

PresignedUrlResponse _$PresignedUrlResponseFromJson(
        Map<String, dynamic> json) =>
    PresignedUrlResponse(
      id: json['id'] as String?,
      filename: json['filename'] as String,
      contentType: json['content_type'] as String?,
      url: json['url'] as String,
      uploadMethod: json['upload_method'] as String?,
      publicUrl: json['public_url'] as String?,
      createdAt: json['created_at'] as String?,
      expiration: json['expiration'] as int?,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$PresignedUrlResponseToJson(
    PresignedUrlResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['filename'] = instance.filename;
  writeNotNull('content_type', instance.contentType);
  val['url'] = instance.url;
  writeNotNull('upload_method', instance.uploadMethod);
  writeNotNull('public_url', instance.publicUrl);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('expiration', instance.expiration);
  writeNotNull('method', instance.method);
  return val;
}
