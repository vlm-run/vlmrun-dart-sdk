import '../../vlmrun_client.dart';
import 'chat_completions.dart';
import 'models.dart';

/// Resource class for OpenAI-compatible endpoints.
class OpenAIResource {
  OpenAIResource(this._client);

  final Vlmrun _client;

  /// Access to chat completion endpoints.
  late final chatCompletions = ChatCompletionsResource(_client);

  /// Access to model-related endpoints.
  late final models = ModelsResource(_client);

  /// Check the health of the OpenAI API.
  Future<void> health() async {
    await _client.request('GET', '/v1/openai/health');
  }
}
