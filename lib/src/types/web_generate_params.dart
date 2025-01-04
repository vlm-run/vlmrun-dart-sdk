import 'package:json_annotation/json_annotation.dart';

part 'web_generate_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WebGenerateParams {
  WebGenerateParams({
    required this.url,
    this.id,
    this.callbackUrl,
    this.createdAt,
    this.domain,
    this.metadata,
    this.mode = 'fast',
    this.model = 'vlm-1',
  });

  final String url;
  final String? id;
  @JsonKey(name: 'callback_url')
  final String? callbackUrl;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? domain;
  final WebMetadata? metadata;
  final String mode;
  final String model;

  factory WebGenerateParams.fromJson(Map<String, dynamic> json) =>
      _$WebGenerateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$WebGenerateParamsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WebMetadata {
  WebMetadata({
    this.allowTraining = false,
    this.environment = 'dev',
    this.sessionId,
  });

  @JsonKey(name: 'allow_training')
  final bool allowTraining;
  final String environment;
  @JsonKey(name: 'session_id')
  final String? sessionId;

  factory WebMetadata.fromJson(Map<String, dynamic> json) =>
      _$WebMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$WebMetadataToJson(this);
}
