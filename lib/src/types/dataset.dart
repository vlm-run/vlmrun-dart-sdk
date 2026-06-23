import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';

part 'dataset.g.dart';

/// Response containing dataset metadata.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class DatasetResponse {
  /// Creates a [DatasetResponse] instance.
  DatasetResponse({
    required this.id,
    required this.datasetType,
    required this.datasetName,
    required this.domain,
    this.fileId,
    this.message,
    this.wandbBaseUrl,
    this.wandbProjectName,
    this.wandbUrl,
    required this.createdAt,
    this.completedAt,
    required this.status,
    this.usage,
  });

  /// Unique dataset identifier.
  final String id;

  /// Dataset type (`images`, `videos`, or `documents`).
  final String datasetType;

  /// Dataset name.
  final String datasetName;

  /// Domain the dataset belongs to.
  final String domain;

  /// Associated file ID.
  final String? fileId;

  /// Optional status message.
  final String? message;

  /// Weights & Biases base URL.
  final String? wandbBaseUrl;

  /// Weights & Biases project name.
  final String? wandbProjectName;

  /// Weights & Biases run URL.
  final String? wandbUrl;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 completion timestamp.
  final String? completedAt;

  /// Processing status.
  final String status;

  /// Credit usage for dataset creation.
  final CreditUsage? usage;

  /// Deserializes from JSON.
  factory DatasetResponse.fromJson(Map<String, dynamic> json) =>
      _$DatasetResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$DatasetResponseToJson(this);
}
