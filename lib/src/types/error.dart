import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

/// Base error class for VLM API errors.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VlmError implements Exception {
  /// Creates a [VlmError] with the given [statusCode] and [details].
  VlmError({
    required this.statusCode,
    required this.details,
  });

  /// HTTP status code.
  final int statusCode;

  /// Error details from the API response.
  final Map<String, dynamic> details;

  /// Deserializes from JSON.
  factory VlmError.fromJson(Map<String, dynamic> json) =>
      _$VlmErrorFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$VlmErrorToJson(this);

  @override
  String toString() => 'VlmError: $statusCode - $details';
}

/// Thrown on HTTP 400 responses.
class BadRequestError extends VlmError {
  /// Creates a [BadRequestError].
  BadRequestError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

/// Thrown on HTTP 404 responses.
class NotFoundError extends VlmError {
  /// Creates a [NotFoundError].
  NotFoundError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

/// Thrown on HTTP 401 responses.
class AuthenticationError extends VlmError {
  /// Creates an [AuthenticationError].
  AuthenticationError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

/// Thrown on HTTP 429 responses.
class RateLimitError extends VlmError {
  /// Creates a [RateLimitError].
  RateLimitError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

/// Thrown on HTTP 5xx responses.
class InternalServerError extends VlmError {
  /// Creates an [InternalServerError].
  InternalServerError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}
