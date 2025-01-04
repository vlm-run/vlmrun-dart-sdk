import 'package:json_annotation/json_annotation.dart';

part 'model_info_response.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ModelInfoResponse {
  ModelInfoResponse({
    required this.domain,
    this.model,
  });

  final String domain;
  final String? model;

  factory ModelInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ModelInfoResponseToJson(this);
}
