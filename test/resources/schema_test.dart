import 'package:test/test.dart';
import 'package:vlm/vlm.dart';

import '../helpers.dart';

void main() {
  late MockHttpClient mockClient;
  late Vlm client;

  setUp(() {
    mockClient = MockHttpClient();
    client = Vlm(
      bearerToken: 'test-token',
      httpClient: mockClient,
    );
  });

  group('Schema', () {
    test('generates schema prediction successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/schema/generate',
        MockResponse(
          body: '''
          {
            "prediction": {
              "name": "John Doe",
              "age": 30,
              "email": "john@example.com"
            },
            "schema": {
              "type": "object",
              "properties": {
                "name": {"type": "string"},
                "age": {"type": "integer"},
                "email": {"type": "string"}
              }
            }
          }
          ''',
        ),
      );

      final response = await client.schema.generate(
        prompt: 'Generate a user profile',
        schema: {
          'type': 'object',
          'properties': {
            'name': {'type': 'string'},
            'age': {'type': 'integer'},
            'email': {'type': 'string'},
          },
        },
      );

      final prediction = response.prediction as Map<String, dynamic>;
      expect(prediction['name'], equals('John Doe'));
      expect(prediction['age'], equals(30));
      expect(prediction['email'], equals('john@example.com'));
    });

    test('handles schema validation error', () async {
      mockClient.addResponse(
        'POST',
        '/v1/schema/generate',
        MockResponse(
          statusCode: 400,
          body: '''
          {
            "error": {
              "message": "Invalid schema",
              "code": "invalid_schema"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.schema.generate(
          prompt: 'Generate invalid data',
          schema: {'invalid': 'schema'},
        ),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('handles generation error', () async {
      mockClient.addResponse(
        'POST',
        '/v1/schema/generate',
        MockResponse(
          statusCode: 500,
          body: '''
          {
            "error": {
              "message": "Generation failed",
              "code": "generation_error"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.schema.generate(
          prompt: 'Generate something',
          schema: {'type': 'object'},
        ),
        throwsA(isA<InternalServerError>()),
      );
    });
  });
}
