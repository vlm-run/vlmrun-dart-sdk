import 'package:json_annotation/json_annotation.dart';

part 'credit_usage.g.dart';

/// Credit consumption details for a request.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class CreditUsage {
  /// Creates a [CreditUsage] instance.
  CreditUsage({
    this.elementsProcessed,
    this.elementType,
    this.creditsUsed,
    this.steps,
    this.message,
    this.durationSeconds = 0,
  });

  /// Number of elements (pages, frames, etc.) processed.
  final int? elementsProcessed;

  /// Type of element processed (e.g., `page`, `frame`).
  final String? elementType;

  /// Total credits consumed.
  final int? creditsUsed;

  /// Number of processing steps taken.
  final int? steps;

  /// Optional status message.
  final String? message;

  /// Total processing duration in seconds.
  final int durationSeconds;

  /// Deserializes from JSON.
  factory CreditUsage.fromJson(Map<String, dynamic> json) =>
      _$CreditUsageFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$CreditUsageToJson(this);
}
