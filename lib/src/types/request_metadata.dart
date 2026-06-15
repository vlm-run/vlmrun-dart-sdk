import 'package:json_annotation/json_annotation.dart';

part 'request_metadata.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class RequestMetadata {
  RequestMetadata({
    this.environment = 'dev',
    this.sessionId,
    this.allowTraining = true,
  });

  final String environment;
  final String? sessionId;
  final bool allowTraining;

  factory RequestMetadata.fromJson(Map<String, dynamic> json) =>
      _$RequestMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMetadataToJson(this);
}
