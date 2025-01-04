import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

/// Response type for file operations
@JsonSerializable(includeIfNull: false)
class StoreFileResponse {
  /// Creates a new [StoreFileResponse] instance.
  StoreFileResponse({
    required this.bytes,
    required this.filename,
    required this.purpose,
    this.id,
    this.createdAt,
    this.object = 'file',
  });

  /// Size of the file in bytes
  final int bytes;

  /// Name of the file
  final String filename;

  /// Purpose of the file
  final String purpose;

  /// Unique identifier of the file
  final String? id;

  /// Date and time when the file was created (in UTC timezone)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// Type of the file
  final String? object;

  /// Creates a [StoreFileResponse] from a JSON map.
  factory StoreFileResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreFileResponseFromJson(json);

  /// Converts this [StoreFileResponse] to a JSON map.
  Map<String, dynamic> toJson() => _$StoreFileResponseToJson(this);
}

/// Response type for listing files
typedef FileListResponse = List<StoreFileResponse>;
