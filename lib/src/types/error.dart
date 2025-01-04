import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VlmError implements Exception {
  VlmError({
    required this.statusCode,
    required this.details,
  });

  final int statusCode;
  final Map<String, dynamic> details;

  factory VlmError.fromJson(Map<String, dynamic> json) => _$VlmErrorFromJson(json);
  
  Map<String, dynamic> toJson() => _$VlmErrorToJson(this);

  @override
  String toString() => 'VlmError: $statusCode - $details';
}

class BadRequestError extends VlmError {
  BadRequestError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

class NotFoundError extends VlmError {
  NotFoundError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

class AuthenticationError extends VlmError {
  AuthenticationError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

class RateLimitError extends VlmError {
  RateLimitError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}

class InternalServerError extends VlmError {
  InternalServerError({
    required int statusCode,
    required Map<String, dynamic> details,
  }) : super(statusCode: statusCode, details: details);
}
