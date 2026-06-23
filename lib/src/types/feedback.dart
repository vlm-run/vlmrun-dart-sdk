import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

/// A single feedback entry.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackItem {
  /// Creates a [FeedbackItem] instance.
  FeedbackItem({
    required this.id,
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.createdAt,
    this.response,
    this.notes,
  });

  /// Unique feedback identifier.
  final String id;

  /// Associated prediction request ID.
  final String? requestId;

  /// Associated agent execution ID.
  final String? agentExecutionId;

  /// Associated chat session ID.
  final String? chatId;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// Ground-truth response data.
  final Map<String, dynamic>? response;

  /// Free-text notes.
  final String? notes;

  /// Deserializes from JSON.
  factory FeedbackItem.fromJson(Map<String, dynamic> json) =>
      _$FeedbackItemFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FeedbackItemToJson(this);
}

/// Paginated list of feedback items.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackListResponse {
  /// Creates a [FeedbackListResponse] instance.
  FeedbackListResponse({
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.items,
  });

  /// Filter: prediction request ID.
  final String? requestId;

  /// Filter: agent execution ID.
  final String? agentExecutionId;

  /// Filter: chat session ID.
  final String? chatId;

  /// Feedback entries.
  final List<FeedbackItem> items;

  /// Deserializes from JSON.
  factory FeedbackListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackListResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FeedbackListResponseToJson(this);
}

/// Request payload for submitting feedback.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackSubmitRequest {
  /// Creates a [FeedbackSubmitRequest] instance.
  FeedbackSubmitRequest({
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    this.response,
    this.notes,
  });

  /// Target prediction request ID.
  final String? requestId;

  /// Target agent execution ID.
  final String? agentExecutionId;

  /// Target chat session ID.
  final String? chatId;

  /// Ground-truth response data.
  final Map<String, dynamic>? response;

  /// Free-text notes.
  final String? notes;

  /// Deserializes from JSON.
  factory FeedbackSubmitRequest.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSubmitRequestFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FeedbackSubmitRequestToJson(this);
}

/// Response after successfully submitting feedback.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class FeedbackSubmitResponse {
  /// Creates a [FeedbackSubmitResponse] instance.
  FeedbackSubmitResponse({
    required this.id,
    this.requestId,
    this.agentExecutionId,
    this.chatId,
    required this.createdAt,
  });

  /// Unique feedback identifier.
  final String id;

  /// Associated prediction request ID.
  final String? requestId;

  /// Associated agent execution ID.
  final String? agentExecutionId;

  /// Associated chat session ID.
  final String? chatId;

  /// ISO 8601 creation timestamp.
  final String createdAt;

  /// Deserializes from JSON.
  factory FeedbackSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSubmitResponseFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$FeedbackSubmitResponseToJson(this);
}
