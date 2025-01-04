import 'dart:convert';

import '../../types/openai/chat_completion.dart';
import '../../vlm_client.dart';
import '../../types/error.dart';

/// Resource class for chat completion endpoints.
class ChatCompletionsResource {
  ChatCompletionsResource(this._client);

  final Vlm _client;

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

    if (response.statusCode != 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      switch (response.statusCode) {
        case 400:
          throw BadRequestError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 401:
          throw AuthenticationError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 404:
          throw NotFoundError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 429:
          throw RateLimitError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        default:
          throw InternalServerError(
            statusCode: response.statusCode,
            details: responseJson,
          );
      }
    }

    return ChatCompletion.fromJson(json);
  }
}
