import 'package:json_annotation/json_annotation.dart';

part 'generation_config.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GenerationConfig {
  GenerationConfig({
    this.detail = 'auto',
    this.jsonSchema,
    this.confidence = false,
    this.grounding = false,
    this.gqlStmt,
  });

  final String detail;
  final Map<String, dynamic>? jsonSchema;
  final bool confidence;
  final bool grounding;
  final String? gqlStmt;

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationConfigToJson(this);
}
