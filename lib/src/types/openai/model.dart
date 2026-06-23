import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

/// List of available models.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ModelList {
  /// Creates a [ModelList] instance.
  ModelList({
    required this.object,
    required this.data,
  });

  /// Object type (always `list`).
  final String object;

  /// Available models.
  final List<Model> data;

  /// Deserializes from JSON.
  factory ModelList.fromJson(Map<String, dynamic> json) =>
      _$ModelListFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ModelListToJson(this);
}

/// A model object (OpenAI-compatible).
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Model {
  /// Creates a [Model] instance.
  Model({
    required this.id,
    this.object = 'model',
    required this.created,
    required this.ownedBy,
    this.permission,
    this.root,
    this.parent,
  });

  /// Model identifier.
  final String id;

  /// Object type.
  final String object;

  /// Unix timestamp of creation.
  final int created;

  /// Owner organization.
  final String ownedBy;

  /// Model permissions.
  final List<ModelPermission>? permission;

  /// Root model identifier.
  final String? root;

  /// Parent model identifier.
  final String? parent;

  /// Deserializes from JSON.
  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

/// Permission settings for a model.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class ModelPermission {
  /// Creates a [ModelPermission] instance.
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

  /// Permission identifier.
  final String id;

  /// Object type.
  final String object;

  /// Unix timestamp of creation.
  final int created;

  /// Whether engine creation is allowed.
  final bool allowCreateEngine;

  /// Whether sampling is allowed.
  final bool allowSampling;

  /// Whether log probabilities are allowed.
  final bool allowLogprobs;

  /// Whether search index access is allowed.
  final bool allowSearchIndices;

  /// Whether viewing is allowed.
  final bool allowView;

  /// Whether fine-tuning is allowed.
  final bool allowFineTuning;

  /// Organization this permission applies to.
  final String? organization;

  /// Group this permission applies to.
  final dynamic group;

  /// Whether this permission is blocking.
  final bool isBlocking;

  /// Deserializes from JSON.
  factory ModelPermission.fromJson(Map<String, dynamic> json) =>
      _$ModelPermissionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ModelPermissionToJson(this);
}
