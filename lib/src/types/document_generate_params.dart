import 'package:json_annotation/json_annotation.dart';

part 'document_generate_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DocumentGenerateParams {
  DocumentGenerateParams({
    this.id,
    this.batch = false,
    this.callbackUrl,
    this.createdAt,
    this.detail = 'auto',
    this.domain,
    this.fileId,
    this.jsonSchema,
    this.metadata,
    this.model = 'vlm-1',
    this.url,
  });

  final String? id;
  final bool batch;
  @JsonKey(name: 'callback_url')
  final String? callbackUrl;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String detail;
  final String? domain;
  @JsonKey(name: 'file_id')
  final String? fileId;
  @JsonKey(name: 'json_schema')
  final Map<String, dynamic>? jsonSchema;
  final DocumentMetadata? metadata;
  final String model;
  final String? url;

  factory DocumentGenerateParams.fromJson(Map<String, dynamic> json) =>
      _$DocumentGenerateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentGenerateParamsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DocumentMetadata {
  DocumentMetadata({
    this.allowTraining = false,
    this.environment = 'dev',
    this.sessionId,
  });

  @JsonKey(name: 'allow_training')
  final bool allowTraining;
  final String environment;
  @JsonKey(name: 'session_id')
  final String? sessionId;

  factory DocumentMetadata.fromJson(Map<String, dynamic> json) =>
      _$DocumentMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentMetadataToJson(this);
}
