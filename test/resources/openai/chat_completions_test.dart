import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

import '../../helpers.dart';

void main() {
  late MockHttpClient mockClient;
  late VlmRun client;

  setUp(() {
    mockClient = MockHttpClient();
    client = VlmRun(
      bearerToken: 'test-token',
      httpClient: mockClient,
    );
  });

  group('ChatCompletions', () {
    test('creates chat completion successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/openai/chat/completions',
        MockResponse(
          body: '''
          {
            "id": "chatcmpl-123",
            "object": "chat.completion",
            "created": 1677652288,
            "model": "gpt-4",
            "choices": [{
              "index": 0,
              "message": {
                "role": "assistant",
                "content": "Hello! How can I help you today?"
              },
              "finish_reason": "stop"
            }],
            "usage": {
              "prompt_tokens": 9,
              "completion_tokens": 12,
              "total_tokens": 21
            }
          }
          ''',
        ),
      );

      final response = await client.openai.chat.create(
        messages: [
          ChatMessage(
            role: 'user',
            content: 'Hello!',
          ),
        ],
        model: 'gpt-4',
      );

      expect(response.id, equals('chatcmpl-123'));
      expect(response.object, equals('chat.completion'));
      expect(response.model, equals('gpt-4'));
      expect(response.choices.length, equals(1));
      expect(response.choices[0].message.role, equals('assistant'));
      expect(
        response.choices[0].message.content,
        equals('Hello! How can I help you today?'),
      );
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'POST',
        '/v1/openai/chat/completions',
        MockResponse(
          statusCode: 400,
          body: '''
          {
            "error": {
              "message": "Invalid request",
              "code": "invalid_request"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.openai.chat.create(
          messages: [],
          model: 'invalid-model',
        ),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
