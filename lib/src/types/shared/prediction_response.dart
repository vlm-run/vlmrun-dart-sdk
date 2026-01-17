import 'package:json_annotation/json_annotation.dart';
import '../credit_usage.dart';

part 'prediction_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PredictionResponse {
  PredictionResponse({
    required this.id,
    required this.createdAt,
    this.completedAt,
    this.response,
    this.status = 'pending',
    this.message,
    this.usage,
  });

  /// Unique identifier of the response.
  final String id;

  /// Date and time when the request was created (in UTC timezone)
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// Date and time when the response was completed (in UTC timezone)
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  /// The response from the model.
  final Map<String, dynamic>? response;

  /// The status of the job.
  final String status;

  /// Optional message (e.g., error message).
  final String? message;

  /// Credit usage information.
  final CreditUsage? usage;

  factory PredictionResponse.fromJson(Map<String, dynamic> json) =>
      _$PredictionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('PredictionResponse {');
    buffer.writeln('  id: $id');
    buffer.writeln('  status: $status');
    buffer.writeln('  createdAt: $createdAt');
    if (completedAt != null) {
      buffer.writeln('  completedAt: $completedAt');
    }
    if (response != null) {
      buffer.writeln('  response: ${response.toString()}');
    }
    buffer.write('}');
    return buffer.toString();
  }
}
