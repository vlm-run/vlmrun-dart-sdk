import 'package:json_annotation/json_annotation.dart';

part 'chat_completion.g.dart';

/// A chat completion response (OpenAI-compatible).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatCompletion {
  /// Creates a [ChatCompletion] instance.
  ChatCompletion({
    required this.id,
    this.object = 'chat.completion',
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  /// Unique completion identifier.
  final String id;

  /// Object type.
  final String object;

  /// Unix timestamp of creation.
  final int created;

  /// Model used for completion.
  final String model;

  /// List of completion choices.
  final List<ChatCompletionChoice> choices;

  /// Token usage statistics.
  final ChatCompletionUsage usage;

  /// Deserializes from JSON.
  factory ChatCompletion.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ChatCompletionToJson(this);
}

/// A single choice in a chat completion response.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatCompletionChoice {
  /// Creates a [ChatCompletionChoice] instance.
  ChatCompletionChoice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  /// Choice index.
  final int index;

  /// The generated message.
  final ChatMessage message;

  /// Reason the model stopped (e.g., `stop`, `length`).
  @JsonKey(name: 'finish_reason')
  final String finishReason;

  /// Deserializes from JSON.
  factory ChatCompletionChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionChoiceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ChatCompletionChoiceToJson(this);
}

/// A chat message with role and content.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatMessage {
  /// Creates a [ChatMessage] instance.
  ChatMessage({
    required this.role,
    required this.content,
  });

  /// Message role (`system`, `user`, or `assistant`).
  final String role;

  /// Message text content.
  final String content;

  /// Deserializes from JSON.
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

/// Token usage statistics for a chat completion.
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class ChatCompletionUsage {
  /// Creates a [ChatCompletionUsage] instance.
  ChatCompletionUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  /// Tokens in the prompt.
  final int promptTokens;

  /// Tokens in the completion.
  final int completionTokens;

  /// Total tokens used.
  final int totalTokens;

  /// Deserializes from JSON.
  factory ChatCompletionUsage.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionUsageFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$ChatCompletionUsageToJson(this);
}
