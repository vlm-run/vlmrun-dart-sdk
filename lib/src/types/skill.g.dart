// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillInfo _$SkillInfoFromJson(Map<String, dynamic> json) => SkillInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      skillVersion: json['skill_version'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      isPublic: json['is_public'] as bool?,
    );

Map<String, dynamic> _$SkillInfoToJson(SkillInfo instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('skill_version', instance.skillVersion);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('status', instance.status);
  writeNotNull('is_public', instance.isPublic);
  return val;
}

SkillDownloadResponse _$SkillDownloadResponseFromJson(
        Map<String, dynamic> json) =>
    SkillDownloadResponse(
      downloadUrl: json['download_url'] as String,
      expiresIn: json['expires_in'] as int?,
    );

Map<String, dynamic> _$SkillDownloadResponseToJson(
    SkillDownloadResponse instance) {
  final val = <String, dynamic>{
    'download_url': instance.downloadUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expires_in', instance.expiresIn);
  return val;
}

AgentSkill _$AgentSkillFromJson(Map<String, dynamic> json) => AgentSkill(
      type: json['type'] as String? ?? 'skill_reference',
      skillId: json['skill_id'] as String?,
      skillName: json['skill_name'] as String?,
      skillVersion: json['skill_version'] as String? ?? 'latest',
      name: json['name'] as String?,
      description: json['description'] as String?,
      source: json['source'] == null
          ? null
          : InlineSkillSource.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgentSkillToJson(AgentSkill instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skill_id', instance.skillId);
  writeNotNull('skill_name', instance.skillName);
  writeNotNull('skill_version', instance.skillVersion);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('source', instance.source?.toJson());
  return val;
}

InlineSkillSource _$InlineSkillSourceFromJson(Map<String, dynamic> json) =>
    InlineSkillSource(
      type: json['type'] as String? ?? 'base64',
      mediaType: json['media_type'] as String? ?? 'application/zip',
      data: json['data'] as String,
    );

Map<String, dynamic> _$InlineSkillSourceToJson(InlineSkillSource instance) =>
    <String, dynamic>{
      'type': instance.type,
      'media_type': instance.mediaType,
      'data': instance.data,
    };
