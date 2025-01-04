import 'package:json_annotation/json_annotation.dart';

part 'audio_generate_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioGenerateParams {
  AudioGenerateParams({
    this.id,
    this.batch = false,
    this.callbackUrl,
    this.createdAt,
    this.domain = 'audio.transcription',
    this.fileId,
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
  final String domain;
  @JsonKey(name: 'file_id')
  final String? fileId;
  final AudioMetadata? metadata;
  final String model;
  final String? url;

  factory AudioGenerateParams.fromJson(Map<String, dynamic> json) =>
      _$AudioGenerateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AudioGenerateParamsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioMetadata {
  AudioMetadata({
    this.allowTraining = false,
    this.environment = 'dev',
    this.sessionId,
  });

  @JsonKey(name: 'allow_training')
  final bool allowTraining;
  final String environment;
  @JsonKey(name: 'session_id')
  final String? sessionId;

  factory AudioMetadata.fromJson(Map<String, dynamic> json) =>
      _$AudioMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$AudioMetadataToJson(this);
}
