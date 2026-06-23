import 'package:json_annotation/json_annotation.dart';

part 'request_metadata.g.dart';

/// Metadata attached to prediction requests.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class RequestMetadata {
  /// Creates a [RequestMetadata] instance.
  RequestMetadata({
    this.environment = 'dev',
    this.sessionId,
    this.allowTraining = true,
  });

  /// Environment label (e.g., `dev`, `prod`).
  final String environment;

  /// Optional session identifier for grouping requests.
  final String? sessionId;

  /// Whether to allow using this data for model training.
  final bool allowTraining;

  /// Deserializes from JSON.
  factory RequestMetadata.fromJson(Map<String, dynamic> json) =>
      _$RequestMetadataFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$RequestMetadataToJson(this);
}
