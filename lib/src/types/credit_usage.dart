import 'package:json_annotation/json_annotation.dart';

part 'credit_usage.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class CreditUsage {
  CreditUsage({
    this.elementsProcessed,
    this.elementType,
    this.creditsUsed,
    this.steps,
    this.message,
    this.durationSeconds = 0,
  });

  final int? elementsProcessed;
  final String? elementType;
  final int? creditsUsed;
  final int? steps;
  final String? message;
  final int durationSeconds;

  factory CreditUsage.fromJson(Map<String, dynamic> json) =>
      _$CreditUsageFromJson(json);

  Map<String, dynamic> toJson() => _$CreditUsageToJson(this);
}
