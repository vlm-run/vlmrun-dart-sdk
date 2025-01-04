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

  group('Response', () {
    test('retrieves response successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/response/123',
        MockResponse(
          body: '''
          {
            "id": "123",
            "created_at": "2019-12-27T18:11:19.117Z",
            "completed_at": "2019-12-27T18:11:19.117Z",
            "response": {
              "model": "vlm-1",
              "domain": "document.generative",
              "input": {
                "file_id": "file_123"
              },
              "output": {
                "text": "Response content"
              }
            },
            "status": "completed",
            "error": null
          }
          ''',
        ),
      );

      final response = await client.response.retrieve('123');

      expect(response.id, equals('123'));
      expect(response.status, equals('completed'));
      expect(response.response?['model'], equals('vlm-1'));
      expect(response.response?['domain'], equals('document.generative'));
      expect(response.response?['output']?['text'], equals('Response content'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'GET',
        '/v1/response/invalid',
        MockResponse(
          statusCode: 404,
          body: '''
          {
            "error": {
              "message": "Response not found",
              "code": "not_found"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.response.retrieve('invalid'),
        throwsA(isA<NotFoundError>()),
      );
    });

    test('throws ArgumentError for empty ID', () {
      expect(
        () => client.response.retrieve(''),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
