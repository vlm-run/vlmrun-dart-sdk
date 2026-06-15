import 'package:json_annotation/json_annotation.dart';
import 'credit_usage.dart';

part 'fine_tuning.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FinetuningResponse {
  FinetuningResponse({
    required this.id,
    required this.createdAt,
    this.completedAt,
    required this.status,
    required this.message,
    required this.model,
    this.suffix,
    this.wandbUrl,
    this.wandbBaseUrl,
    this.wandbProjectName,
    this.usage,
  });

  final String id;
  final String createdAt;
  final String? completedAt;
  final String status;
  final String message;
  final String model;
  final String? suffix;
  final String? wandbUrl;
  final String? wandbBaseUrl;
  final String? wandbProjectName;
  final CreditUsage? usage;

  factory FinetuningResponse.fromJson(Map<String, dynamic> json) =>
      _$FinetuningResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinetuningResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FinetuningProvisionResponse {
  FinetuningProvisionResponse({
    required this.id,
    required this.createdAt,
    this.completedAt,
    required this.model,
    required this.message,
  });

  final String id;
  final String createdAt;
  final String? completedAt;
  final String model;
  final String message;

  factory FinetuningProvisionResponse.fromJson(Map<String, dynamic> json) =>
      _$FinetuningProvisionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinetuningProvisionResponseToJson(this);
}
