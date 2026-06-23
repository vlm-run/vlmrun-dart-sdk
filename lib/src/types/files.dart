import 'package:json_annotation/json_annotation.dart';

part 'files.g.dart';

/// Request payload for file upload.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FileRequest {
  /// Creates a [FileRequest] instance.
  FileRequest({
    required this.file,
    this.purpose,
  });

  /// File path or identifier.
  final String file;

  /// Intended purpose (e.g., `vision`, `document`).
  final String? purpose;

  /// Deserializes from JSON.
  factory FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FileRequestToJson(this);
}

/// Metadata for an uploaded file.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FileResponse {
  /// Creates a [FileResponse] instance.
  FileResponse({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
    this.publicUrl,
  });

  /// Unique file identifier.
  final String id;

  /// Object type (always `file`).
  final String object;

  /// File size in bytes.
  final int bytes;

  /// Upload timestamp.
  final DateTime? createdAt;

  /// Original filename.
  final String filename;

  /// File purpose (e.g., `vision`, `document`).
  final String purpose;

  /// Publicly accessible URL, if generated.
  final String? publicUrl;

  /// Deserializes from JSON.
  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}

/// Parameters for listing files.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FileListRequest {
  /// Creates a [FileListRequest] instance.
  FileListRequest({
    this.purpose,
    this.limit,
    this.after,
    this.order,
  });

  /// Filter by purpose.
  final String? purpose;

  /// Maximum number of results.
  final int? limit;

  /// Cursor for pagination.
  final String? after;

  /// Sort order (`asc` or `desc`).
  final String? order;

  /// Deserializes from JSON.
  factory FileListRequest.fromJson(Map<String, dynamic> json) =>
      _$FileListRequestFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FileListRequestToJson(this);
}
