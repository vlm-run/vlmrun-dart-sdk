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

  group('Web', () {
    test('generates web prediction successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/web/generate',
        MockResponse(
          body: '''
          {
            "id": "123",
            "created_at": "2019-12-27T18:11:19.117Z",
            "completed_at": "2019-12-27T18:11:19.117Z",
            "response": {
              "model": "vlm-1",
              "domain": "web.ecommerce-product-catalog",
              "output": {
                "text": "Web content"
              }
            },
            "status": "completed"
          }
          ''',
        ),
      );

      final response = await client.web.generate(
        url: 'https://example.com',
        id: 'id',
        callbackUrl: 'https://callback.com',
        createdAt: DateTime.parse('2019-12-27T18:11:19.117Z'),
        domain: 'web.ecommerce-product-catalog',
        metadata: WebMetadata(
          allowTraining: true,
          environment: 'dev',
          sessionId: 'session_id',
        ),
        mode: 'fast',
        model: 'vlm-1',
      );

      expect(response.id, equals('123'));
      expect(response.status, equals('completed'));
      expect(response.response?['model'], equals('vlm-1'));
      expect(response.response?['domain'],
          equals('web.ecommerce-product-catalog'));
      expect(response.response?['output']?['text'], equals('Web content'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'POST',
        '/v1/web/generate',
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
        () => client.web.generate(url: ''),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
