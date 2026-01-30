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
        FilePredictionParams(
          fileId: 'file_123',
          domain: 'document.generative',
          model: 'vlm-1',
          batch: true,
          config: GenerationConfig(
            detail: 'hi',
            jsonSchema: {'type': 'object'},
          ),
          metadata: RequestMetadata(
            allowTraining: true,
            environment: 'dev',
            sessionId: 'session_id',
          ),
          callbackUrl: 'https://example.com',
        ),
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
        () => client.document.generate(
          FilePredictionParams(
            fileId: 'file_id',
            domain: 'document.generative',
          ),
        ),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('throws InputError when neither fileId nor url provided', () {
      expect(
        () => client.document.generate(
          FilePredictionParams(domain: 'document.generative'),
        ),
        throwsA(isA<InputError>()),
      );
    });

    test('throws InputError when both fileId and url provided', () {
      expect(
        () => client.document.generate(
          FilePredictionParams(
            fileId: 'file_id',
            url: 'https://example.com/document.pdf',
            domain: 'document.generative',
          ),
        ),
        throwsA(isA<InputError>()),
      );
    });
  });
}
