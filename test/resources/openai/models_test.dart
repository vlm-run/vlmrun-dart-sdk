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

  group('Models', () {
    test('lists models successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models',
        MockResponse(
          body: '''
          {
            "object": "list",
            "data": [
              {
                "id": "gpt-4",
                "object": "model",
                "created": 1677610602,
                "owned_by": "openai"
              },
              {
                "id": "gpt-3.5-turbo",
                "object": "model",
                "created": 1677649963,
                "owned_by": "openai"
              }
            ]
          }
          ''',
        ),
      );

      final response = await client.openai.models.list();

      expect(response.object, equals('list'));
      expect(response.data.length, equals(2));
      expect(response.data[0].id, equals('gpt-4'));
      expect(response.data[1].id, equals('gpt-3.5-turbo'));
    });

    test('retrieves specific model successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models/gpt-4',
        MockResponse(
          body: '''
          {
            "id": "gpt-4",
            "object": "model",
            "created": 1677610602,
            "owned_by": "openai"
          }
          ''',
        ),
      );

      final model = await client.openai.models.retrieve('gpt-4');

      expect(model.id, equals('gpt-4'));
      expect(model.object, equals('model'));
      expect(model.ownedBy, equals('openai'));
    });

    test('handles not found error', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models/invalid-model',
        MockResponse(
          statusCode: 404,
          body: '''
          {
            "error": {
              "message": "Model not found",
              "code": "model_not_found"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.openai.models.retrieve('invalid-model'),
        throwsA(isA<NotFoundError>()),
      );
    });
  });
}
