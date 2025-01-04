import '../vlm_client.dart';
import 'openai/chat_completions.dart';
import 'openai/models.dart';

/// OpenAI API resources.
class OpenAI {
  OpenAI(this._client);

  final Vlm _client;

  /// Access to chat endpoints.
  late final chat = ChatCompletionsResource(_client);

  /// Access to models endpoints.
  late final models = ModelsResource(_client);
}
