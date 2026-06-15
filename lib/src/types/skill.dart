import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SkillInfo {
  SkillInfo({
    required this.id,
    required this.name,
    this.description,
    this.skillVersion,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isPublic,
  });

  final String id;
  final String name;
  final String? description;
  final String? skillVersion;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final bool? isPublic;

  factory SkillInfo.fromJson(Map<String, dynamic> json) =>
      _$SkillInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SkillInfoToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SkillDownloadResponse {
  SkillDownloadResponse({
    required this.downloadUrl,
    this.expiresIn,
  });

  final String downloadUrl;
  final int? expiresIn;

  factory SkillDownloadResponse.fromJson(Map<String, dynamic> json) =>
      _$SkillDownloadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SkillDownloadResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentSkill {
  AgentSkill({
    this.type = 'skill_reference',
    this.skillId,
    this.skillName,
    this.skillVersion = 'latest',
    this.name,
    this.description,
    this.source,
  });

  final String type;
  final String? skillId;
  final String? skillName;
  final String? skillVersion;
  final String? name;
  final String? description;
  final InlineSkillSource? source;

  factory AgentSkill.fromJson(Map<String, dynamic> json) =>
      _$AgentSkillFromJson(json);

  Map<String, dynamic> toJson() => _$AgentSkillToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class InlineSkillSource {
  InlineSkillSource({
    this.type = 'base64',
    this.mediaType = 'application/zip',
    required this.data,
  });

  final String type;
  final String mediaType;
  final String data;

  factory InlineSkillSource.fromJson(Map<String, dynamic> json) =>
      _$InlineSkillSourceFromJson(json);

  Map<String, dynamic> toJson() => _$InlineSkillSourceToJson(this);
}
