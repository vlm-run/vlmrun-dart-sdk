import 'package:json_annotation/json_annotation.dart';

part 'presigned_url.g.dart';

/// Request for generating a presigned upload URL.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class PresignedUrlRequest {
  /// Creates a [PresignedUrlRequest] instance.
  PresignedUrlRequest({
    required this.filename,
    this.purpose,
  });

  /// Name of the file to upload.
  final String filename;

  /// Intended purpose (e.g., `vision`, `document`).
  final String? purpose;

  /// Deserializes from JSON.
  factory PresignedUrlRequest.fromJson(Map<String, dynamic> json) =>
      _$PresignedUrlRequestFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$PresignedUrlRequestToJson(this);
}

/// Presigned URL details for direct file upload.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class PresignedUrlResponse {
  /// Creates a [PresignedUrlResponse] instance.
  PresignedUrlResponse({
    this.id,
    required this.filename,
    this.contentType,
    required this.url,
    this.uploadMethod,
    this.publicUrl,
    this.createdAt,
    this.expiration,
    this.method,
  });

  /// File identifier.
  final String? id;

  /// Original filename.
  final String filename;

  /// MIME content type.
  final String? contentType;

  /// Presigned upload URL.
  final String url;

  /// HTTP method for upload (e.g., `PUT`).
  final String? uploadMethod;

  /// Public URL after upload completes.
  final String? publicUrl;

  /// ISO 8601 creation timestamp.
  final String? createdAt;

  /// URL expiration time in seconds.
  final int? expiration;

  /// HTTP method to use.
  final String? method;

  /// Deserializes from JSON.
  factory PresignedUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$PresignedUrlResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$PresignedUrlResponseToJson(this);
}
