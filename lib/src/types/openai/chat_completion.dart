import 'package:json_annotation/json_annotation.dart';

part 'chat_completion.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatCompletion {
  ChatCompletion({
    required this.id,
    this.object = 'chat.completion',
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChatCompletionChoice> choices;
  final ChatCompletionUsage usage;

  factory ChatCompletion.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCompletionToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatCompletionChoice {
  ChatCompletionChoice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  final int index;
  final ChatMessage message;
  @JsonKey(name: 'finish_reason')
  final String finishReason;

  factory ChatCompletionChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCompletionChoiceToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChatMessage {
  ChatMessage({
    required this.role,
    required this.content,
  });

  final String role;
  final String content;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class ChatCompletionUsage {
  ChatCompletionUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  factory ChatCompletionUsage.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionUsageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCompletionUsageToJson(this);
}
