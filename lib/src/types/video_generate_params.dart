import 'package:json_annotation/json_annotation.dart';

part 'video_generate_params.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class VideoMetadata {
  VideoMetadata({
    this.environment = 'dev',
    this.sessionId,
    this.allowTraining = true,
  });

  final String environment;
  final String? sessionId;
  final bool allowTraining;

  factory VideoMetadata.fromJson(Map<String, dynamic> json) =>
      _$VideoMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$VideoMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class VideoGenerateParams {
  VideoGenerateParams({
    this.id,
    this.batch = false,
    this.callbackUrl,
    this.createdAt,
    this.domain,
    this.fileId,
    this.metadata,
    this.model = 'vlm-1',
    this.url,
    this.config,
  });

  final String? id;
  final bool batch;
  final String? callbackUrl;
  final DateTime? createdAt;
  final String? domain;
  final String? fileId;
  final VideoMetadata? metadata;
  final String model;
  final String? url;
  final Map<String, dynamic>? config;

  factory VideoGenerateParams.fromJson(Map<String, dynamic> json) =>
      _$VideoGenerateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VideoGenerateParamsToJson(this);
}
