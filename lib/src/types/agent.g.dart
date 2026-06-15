// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentInfo _$AgentInfoFromJson(Map<String, dynamic> json) => AgentInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      prompt: json['prompt'] as String,
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      jsonSample: json['json_sample'] as Map<String, dynamic>?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AgentInfoToJson(AgentInfo instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'description': instance.description,
    'prompt': instance.prompt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('json_schema', instance.jsonSchema);
  writeNotNull('json_sample', instance.jsonSample);
  val['created_at'] = instance.createdAt;
  val['updated_at'] = instance.updatedAt;
  val['status'] = instance.status;
  return val;
}

AgentExecutionResponse _$AgentExecutionResponseFromJson(
        Map<String, dynamic> json) =>
    AgentExecutionResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
      completedAt: json['completed_at'] as String?,
      response: json['response'] as Map<String, dynamic>?,
      status: json['status'] as String,
      usage: json['usage'] == null
          ? null
          : CreditUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgentExecutionResponseToJson(
    AgentExecutionResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'created_at': instance.createdAt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('completed_at', instance.completedAt);
  writeNotNull('response', instance.response);
  val['status'] = instance.status;
  writeNotNull('usage', instance.usage?.toJson());
  return val;
}

AgentCreationResponse _$AgentCreationResponseFromJson(
        Map<String, dynamic> json) =>
    AgentCreationResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AgentCreationResponseToJson(
        AgentCreationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'status': instance.status,
    };

AgentExecutionConfig _$AgentExecutionConfigFromJson(
        Map<String, dynamic> json) =>
    AgentExecutionConfig(
      prompt: json['prompt'] as String?,
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => AgentSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
      serviceTier: json['service_tier'] as String?,
    );

Map<String, dynamic> _$AgentExecutionConfigToJson(
    AgentExecutionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prompt', instance.prompt);
  writeNotNull('json_schema', instance.jsonSchema);
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  writeNotNull('service_tier', instance.serviceTier);
  return val;
}

AgentCreationConfig _$AgentCreationConfigFromJson(Map<String, dynamic> json) =>
    AgentCreationConfig(
      prompt: json['prompt'] as String?,
      jsonSchema: json['json_schema'] as Map<String, dynamic>?,
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => AgentSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
      serviceTier: json['service_tier'] as String?,
    );

Map<String, dynamic> _$AgentCreationConfigToJson(AgentCreationConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prompt', instance.prompt);
  writeNotNull('json_schema', instance.jsonSchema);
  writeNotNull('skills', instance.skills?.map((e) => e.toJson()).toList());
  writeNotNull('service_tier', instance.serviceTier);
  return val;
}
