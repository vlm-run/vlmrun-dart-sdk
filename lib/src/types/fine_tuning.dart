import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';

part 'fine_tuning.g.dart';

/// Response from a fine-tuning job.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FinetuningResponse {
  /// Creates a [FinetuningResponse] instance.
  FinetuningResponse({
    required this.id,
    required this.createdAt,
    this.completedAt,
    required this.status,
    required this.message,
    required this.model,
    this.suffix,
    this.wandbUrl,
    this.wandbBaseUrl,
    this.wandbProjectName,
    this.usage,
  });

  /// Unique job identifier.
  final String id;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 completion timestamp.
  final String? completedAt;

  /// Job status (e.g., `pending`, `completed`, `failed`).
  final String status;

  /// Status message.
  final String message;

  /// Base model being fine-tuned.
  final String model;

  /// Custom suffix for the fine-tuned model name.
  final String? suffix;

  /// Weights & Biases run URL.
  final String? wandbUrl;

  /// Weights & Biases base URL.
  final String? wandbBaseUrl;

  /// Weights & Biases project name.
  final String? wandbProjectName;

  /// Credit usage for this job.
  final CreditUsage? usage;

  /// Deserializes from JSON.
  factory FinetuningResponse.fromJson(Map<String, dynamic> json) =>
      _$FinetuningResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FinetuningResponseToJson(this);
}

/// Response from provisioning a fine-tuned model.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FinetuningProvisionResponse {
  /// Creates a [FinetuningProvisionResponse] instance.
  FinetuningProvisionResponse({
    required this.id,
    required this.createdAt,
    this.completedAt,
    required this.model,
    required this.message,
  });

  /// Unique provision identifier.
  final String id;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// ISO 8601 completion timestamp.
  final String? completedAt;

  /// Provisioned model identifier.
  final String model;

  /// Status message.
  final String message;

  /// Deserializes from JSON.
  factory FinetuningProvisionResponse.fromJson(Map<String, dynamic> json) =>
      _$FinetuningProvisionResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FinetuningProvisionResponseToJson(this);
}
