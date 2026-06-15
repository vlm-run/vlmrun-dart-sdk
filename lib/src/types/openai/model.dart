import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ModelList {
  ModelList({
    required this.object,
    required this.data,
  });

  final String object;
  final List<Model> data;

  factory ModelList.fromJson(Map<String, dynamic> json) =>
      _$ModelListFromJson(json);

  Map<String, dynamic> toJson() => _$ModelListToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Model {
  Model({
    required this.id,
    this.object = 'model',
    required this.created,
    required this.ownedBy,
    this.permission,
    this.root,
    this.parent,
  });

  final String id;
  final String object;
  final int created;
  final String ownedBy;
  final List<ModelPermission>? permission;
  final String? root;
  final String? parent;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class ModelPermission {
  ModelPermission({
    required this.id,
    this.object = 'model_permission',
    required this.created,
    required this.allowCreateEngine,
    required this.allowSampling,
    required this.allowLogprobs,
    required this.allowSearchIndices,
    required this.allowView,
    required this.allowFineTuning,
    this.organization,
    this.group,
    required this.isBlocking,
  });

  final String id;
  final String object;
  final int created;
  final bool allowCreateEngine;
  final bool allowSampling;
  final bool allowLogprobs;
  final bool allowSearchIndices;
  final bool allowView;
  final bool allowFineTuning;
  final String? organization;
  final dynamic group;
  final bool isBlocking;

  factory ModelPermission.fromJson(Map<String, dynamic> json) =>
      _$ModelPermissionFromJson(json);

  Map<String, dynamic> toJson() => _$ModelPermissionToJson(this);
}
