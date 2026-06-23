import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

/// Metadata for a registered skill.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SkillInfo {
  /// Creates a [SkillInfo] instance.
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

  /// Unique skill identifier.
  final String id;

  /// Skill name.
  final String name;

  /// Human-readable description.
  final String? description;

  /// Semantic version string.
  final String? skillVersion;

  /// ISO 8601 creation timestamp.
  final String? createdAt;

  /// ISO 8601 last-updated timestamp.
  final String? updatedAt;

  /// Current status.
  final String? status;

  /// Whether the skill is publicly available.
  final bool? isPublic;

  /// Deserializes from JSON.
  factory SkillInfo.fromJson(Map<String, dynamic> json) =>
      _$SkillInfoFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$SkillInfoToJson(this);
}

/// Presigned download URL for a skill archive.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class SkillDownloadResponse {
  /// Creates a [SkillDownloadResponse] instance.
  SkillDownloadResponse({
    required this.downloadUrl,
    this.expiresIn,
  });

  /// Presigned URL to download the skill zip.
  final String downloadUrl;

  /// URL expiration time in seconds.
  final int? expiresIn;

  /// Deserializes from JSON.
  factory SkillDownloadResponse.fromJson(Map<String, dynamic> json) =>
      _$SkillDownloadResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$SkillDownloadResponseToJson(this);
}

/// A skill reference or inline skill attached to an agent.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class AgentSkill {
  /// Creates an [AgentSkill] instance.
  AgentSkill({
    this.type = 'skill_reference',
    this.skillId,
    this.skillName,
    this.skillVersion = 'latest',
    this.name,
    this.description,
    this.source,
  });

  /// Skill type (`skill_reference` or `inline`).
  final String type;

  /// Skill ID for referenced skills.
  final String? skillId;

  /// Skill name for referenced skills.
  final String? skillName;

  /// Version to use (default: `latest`).
  final String? skillVersion;

  /// Display name for inline skills.
  final String? name;

  /// Description for inline skills.
  final String? description;

  /// Inline skill source data.
  final InlineSkillSource? source;

  /// Deserializes from JSON.
  factory AgentSkill.fromJson(Map<String, dynamic> json) =>
      _$AgentSkillFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$AgentSkillToJson(this);
}

/// Source data for an inline skill (base64-encoded zip).
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class InlineSkillSource {
  /// Creates an [InlineSkillSource] instance.
  InlineSkillSource({
    this.type = 'base64',
    this.mediaType = 'application/zip',
    required this.data,
  });

  /// Encoding type (default: `base64`).
  final String type;

  /// MIME type of the encoded data.
  final String mediaType;

  /// Base64-encoded skill archive.
  final String data;

  /// Deserializes from JSON.
  factory InlineSkillSource.fromJson(Map<String, dynamic> json) =>
      _$InlineSkillSourceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$InlineSkillSourceToJson(this);
}
