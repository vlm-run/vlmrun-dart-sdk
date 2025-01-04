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

  group('Document', () {
    test('generates document prediction successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/document/generate',
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
                "text": "Document content"
              }
            },
            "status": "completed"
          }
          ''',
        ),
      );

      final response = await client.document.generate(
        id: 'id',
        batch: true,
        callbackUrl: 'https://example.com',
        createdAt: DateTime.parse('2019-12-27T18:11:19.117Z'),
        detail: 'hi',
        domain: 'document.generative',
        fileId: 'file_123',
        jsonSchema: {'type': 'object'},
        metadata: DocumentMetadata(
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
      expect(response.response?['output']?['text'], equals('Document content'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'POST',
        '/v1/document/generate',
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
        () => client.document.generate(fileId: ''),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('handles error responses for document generate endpoint', () async {
      mockClient.addResponse(
        'POST',
        '/v1/document/generate',
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
        () => client.document.generate(fileId: ''),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
