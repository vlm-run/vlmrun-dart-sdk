import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackItem {
  FeedbackItem({
    required this.id,
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.createdAt,
    this.response,
    this.notes,
  });

  final String id;
  final String? requestId;
  final String? agentExecutionId;
  final String? chatId;
  final String createdAt;
  final Map<String, dynamic>? response;
  final String? notes;

  factory FeedbackItem.fromJson(Map<String, dynamic> json) =>
      _$FeedbackItemFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackItemToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackListResponse {
  FeedbackListResponse({
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.items,
  });

  final String? requestId;
  final String? agentExecutionId;
  final String? chatId;
  final List<FeedbackItem> items;

  factory FeedbackListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackListResponseToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackSubmitRequest {
  FeedbackSubmitRequest({
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    this.response,
    this.notes,
  });

  final String? requestId;
  final String? agentExecutionId;
  final String? chatId;
  final Map<String, dynamic>? response;
  final String? notes;

  factory FeedbackSubmitRequest.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSubmitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackSubmitRequestToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackSubmitResponse {
  FeedbackSubmitResponse({
    required this.id,
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.createdAt,
  });

  final String id;
  final String? requestId;
  final String? agentExecutionId;
  final String? chatId;
  final String createdAt;

  factory FeedbackSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSubmitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackSubmitResponseToJson(this);
}
