import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

import '../helpers.dart';

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

  group('Image', () {
    test('generates image prediction successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/image/generate',
        MockResponse(
          body: '''
          {
            "id": "123",
            "created_at": "2019-12-27T18:11:19.117Z",
            "completed_at": "2019-12-27T18:11:19.117Z",
            "response": {
              "model": "vlm-1",
              "domain": "document.generative",
              "output": {
                "text": "A beautiful landscape"
              }
            },
            "status": "completed"
          }
          ''',
        ),
      );

      final response = await client.image.generate(
        image: 'base64_encoded_image',
        id: 'id',
        callbackUrl: 'https://example.com',
        createdAt: DateTime.parse('2019-12-27T18:11:19.117Z'),
        detail: 'hi',
        domain: 'document.generative',
        jsonSchema: {'type': 'object'},
        metadata: ImageMetadata(
          allowTraining: true,
          environment: 'dev',
          sessionId: 'session_id',
        ),
        model: 'vlm-1',
      );

      expect(response.id, equals('123'));
      expect(response.status, equals('completed'));
      expect(response.response?['model'], equals('vlm-1'));
      expect(response.response?['domain'], equals('document.generative'));
      expect(response.response?['output']?['text'],
          equals('A beautiful landscape'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'POST',
        '/v1/image/generate',
        MockResponse(
          statusCode: 400,
          body: '''
          {
            "error": {
              "code": "bad_request",
              "message": "Invalid request"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.image.generate(image: ''),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('handles error responses for image generate endpoint', () async {
      mockClient.addResponse(
        'POST',
        '/v1/image/generate',
        MockResponse(
          statusCode: 400,
          body: '''
          {
            "error": {
              "code": "bad_request",
              "message": "Invalid request"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.image.generate(image: ''),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
