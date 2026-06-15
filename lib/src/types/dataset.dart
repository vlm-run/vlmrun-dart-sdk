import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';

part 'dataset.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class DatasetResponse {
  DatasetResponse({
    required this.id,
    required this.datasetType,
    required this.datasetName,
    required this.domain,
    this.fileId,
    this.message,
    this.wandbBaseUrl,
    this.wandbProjectName,
    this.wandbUrl,
    required this.createdAt,
    this.completedAt,
    required this.status,
    this.usage,
  });

  final String id;
  final String datasetType;
  final String datasetName;
  final String domain;
  final String? fileId;
  final String? message;
  final String? wandbBaseUrl;
  final String? wandbProjectName;
  final String? wandbUrl;
  final String createdAt;
  final String? completedAt;
  final String status;
  final CreditUsage? usage;

  factory DatasetResponse.fromJson(Map<String, dynamic> json) =>
      _$DatasetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DatasetResponseToJson(this);
}
