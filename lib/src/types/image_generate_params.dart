import 'package:json_annotation/json_annotation.dart';

part 'image_generate_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageGenerateParams {
  ImageGenerateParams({
    required this.images,
    this.id,
    this.callbackUrl,
    this.createdAt,
    this.detail = 'auto',
    this.domain,
    this.jsonSchema,
    this.metadata,
    this.model = 'vlm-1',
  });

  final List<String> images;
  final String? id;
  @JsonKey(name: 'callback_url')
  final String? callbackUrl;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String detail;
  final String? domain;
  @JsonKey(name: 'json_schema')
  final Map<String, dynamic>? jsonSchema;
  final ImageMetadata? metadata;
  final String model;

  factory ImageGenerateParams.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ImageGenerateParamsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageMetadata {
  ImageMetadata({
    this.allowTraining = false,
    this.environment = 'dev',
    this.sessionId,
  });

  @JsonKey(name: 'allow_training')
  final bool allowTraining;
  final String environment;
  @JsonKey(name: 'session_id')
  final String? sessionId;

  factory ImageMetadata.fromJson(Map<String, dynamic> json) =>
      _$ImageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMetadataToJson(this);
}
