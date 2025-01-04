import 'package:json_annotation/json_annotation.dart';

part 'files.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FileRequest {
  FileRequest({
    required this.file,
    this.purpose,
  });

  final String file;
  final String? purpose;

  factory FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FileResponse {
  FileResponse({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  final String id;
  final String object;
  final int bytes;
  final DateTime? createdAt;
  final String filename;
  final String purpose;

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FileListRequest {
  FileListRequest({
    this.purpose,
    this.limit,
    this.after,
    this.order,
  });

  final String? purpose;
  final int? limit;
  final String? after;
  final String? order;

  factory FileListRequest.fromJson(Map<String, dynamic> json) =>
      _$FileListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileListRequestToJson(this);
}
