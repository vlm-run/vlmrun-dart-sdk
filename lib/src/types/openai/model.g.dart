// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelList _$ModelListFromJson(Map<String, dynamic> json) => ModelList(
      object: json['object'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelListToJson(ModelList instance) => <String, dynamic>{
      'object': instance.object,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      id: json['id'] as String,
      object: json['object'] as String? ?? 'model',
      created: (json['created'] as num).toInt(),
      ownedBy: json['owned_by'] as String,
      permission: (json['permission'] as List<dynamic>?)
          ?.map((e) => ModelPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
      root: json['root'] as String?,
      parent: json['parent'] as String?,
    );

Map<String, dynamic> _$ModelToJson(Model instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'object': instance.object,
    'created': instance.created,
    'owned_by': instance.ownedBy,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'permission', instance.permission?.map((e) => e.toJson()).toList());
  writeNotNull('root', instance.root);
  writeNotNull('parent', instance.parent);
  return val;
}

ModelPermission _$ModelPermissionFromJson(Map<String, dynamic> json) =>
    ModelPermission(
      id: json['id'] as String,
      object: json['object'] as String? ?? 'model_permission',
      created: (json['created'] as num).toInt(),
      allowCreateEngine: json['allow_create_engine'] as bool,
      allowSampling: json['allow_sampling'] as bool,
      allowLogprobs: json['allow_logprobs'] as bool,
      allowSearchIndices: json['allow_search_indices'] as bool,
      allowView: json['allow_view'] as bool,
      allowFineTuning: json['allow_fine_tuning'] as bool,
      organization: json['organization'] as String?,
      group: json['group'],
      isBlocking: json['is_blocking'] as bool,
    );

Map<String, dynamic> _$ModelPermissionToJson(ModelPermission instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'object': instance.object,
    'created': instance.created,
    'allow_create_engine': instance.allowCreateEngine,
    'allow_sampling': instance.allowSampling,
    'allow_logprobs': instance.allowLogprobs,
    'allow_search_indices': instance.allowSearchIndices,
    'allow_view': instance.allowView,
    'allow_fine_tuning': instance.allowFineTuning,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('organization', instance.organization);
  writeNotNull('group', instance.group);
  val['is_blocking'] = instance.isBlocking;
  return val;
}
