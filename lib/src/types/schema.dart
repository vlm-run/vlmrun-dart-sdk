import 'package:json_annotation/json_annotation.dart';

part 'schema.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PredictionResponse {
  PredictionResponse({
    required this.prediction,
    this.error,
  });

  final dynamic prediction;
  final String? error;

  factory PredictionResponse.fromJson(Map<String, dynamic> json) =>
      _$PredictionResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);
}
