// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackItem _$FeedbackItemFromJson(Map<String, dynamic> json) => FeedbackItem(
      id: json['id'] as String,
      requestId: json['request_id'] as String?,
      agentExecutionId: json['agent_execution_id'] as String?,
      chatId: json['chat_id'] as String?,
      createdAt: json['created_at'] as String,
      response: json['response'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$FeedbackItemToJson(FeedbackItem instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('request_id', instance.requestId);
  writeNotNull('agent_execution_id', instance.agentExecutionId);
  writeNotNull('chat_id', instance.chatId);
  val['created_at'] = instance.createdAt;
  writeNotNull('response', instance.response);
  writeNotNull('notes', instance.notes);
  return val;
}

FeedbackListResponse _$FeedbackListResponseFromJson(
        Map<String, dynamic> json) =>
    FeedbackListResponse(
      requestId: json['request_id'] as String?,
      agentExecutionId: json['agent_execution_id'] as String?,
      chatId: json['chat_id'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => FeedbackItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackListResponseToJson(
    FeedbackListResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('request_id', instance.requestId);
  writeNotNull('agent_execution_id', instance.agentExecutionId);
  writeNotNull('chat_id', instance.chatId);
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  return val;
}

FeedbackSubmitRequest _$FeedbackSubmitRequestFromJson(
        Map<String, dynamic> json) =>
    FeedbackSubmitRequest(
      requestId: json['request_id'] as String?,
      agentExecutionId: json['agent_execution_id'] as String?,
      chatId: json['chat_id'] as String?,
      response: json['response'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$FeedbackSubmitRequestToJson(
    FeedbackSubmitRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('request_id', instance.requestId);
  writeNotNull('agent_execution_id', instance.agentExecutionId);
  writeNotNull('chat_id', instance.chatId);
  writeNotNull('response', instance.response);
  writeNotNull('notes', instance.notes);
  return val;
}

FeedbackSubmitResponse _$FeedbackSubmitResponseFromJson(
        Map<String, dynamic> json) =>
    FeedbackSubmitResponse(
      id: json['id'] as String,
      requestId: json['request_id'] as String?,
      agentExecutionId: json['agent_execution_id'] as String?,
      chatId: json['chat_id'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$FeedbackSubmitResponseToJson(
    FeedbackSubmitResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('request_id', instance.requestId);
  writeNotNull('agent_execution_id', instance.agentExecutionId);
  writeNotNull('chat_id', instance.chatId);
  val['created_at'] = instance.createdAt;
  return val;
}
