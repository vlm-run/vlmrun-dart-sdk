import 'dart:convert';

import '../../types/openai/chat_completion.dart';
import '../../utils/http_utils.dart';
import '../../vlmrun_client.dart';

/// Resource class for chat completion endpoints.
class ChatCompletionsResource {
  ChatCompletionsResource(this._client);

  final VlmRun _client;

  /// Create a chat completion.
  Future<ChatCompletion> create({
    required List<ChatMessage> messages,
    String? model,
    double? temperature,
    int? maxTokens,
  }) async {
    final params = {
      'messages': messages.map((m) => m.toJson()).toList(),
      if (model != null) 'model': model,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
    };

    final response = await _client.request(
      'POST',
      '/v1/openai/chat/completions',
      body: jsonEncode(params),
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(response.statusCode, json);
    }

    return ChatCompletion.fromJson(json);
  }
}
