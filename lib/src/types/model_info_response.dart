import 'package:json_annotation/json_annotation.dart';

part 'model_info_response.g.dart';

/// Model availability information per domain.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ModelInfoResponse {
  /// Creates a [ModelInfoResponse] instance.
  ModelInfoResponse({
    required this.domain,
    this.model,
  });

  /// Domain the model supports.
  final String domain;

  /// Model identifier.
  final String? model;

  /// Deserializes from JSON.
  factory ModelInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ModelInfoResponseToJson(this);
}
