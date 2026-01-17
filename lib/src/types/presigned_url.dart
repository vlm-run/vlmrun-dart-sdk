import 'package:json_annotation/json_annotation.dart';

part 'presigned_url.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class PresignedUrlRequest {
  PresignedUrlRequest({
    required this.filename,
    this.purpose,
  });

  final String filename;
  final String? purpose;

  factory PresignedUrlRequest.fromJson(Map<String, dynamic> json) =>
      _$PresignedUrlRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PresignedUrlRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class PresignedUrlResponse {
  PresignedUrlResponse({
    this.id,
    required this.filename,
    this.contentType,
    required this.url,
    this.uploadMethod,
    this.publicUrl,
    this.createdAt,
  });

  final String? id;
  final String filename;
  final String? contentType;
  final String url;
  final String? uploadMethod;
  final String? publicUrl;
  final String? createdAt;

  factory PresignedUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$PresignedUrlResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PresignedUrlResponseToJson(this);
}
