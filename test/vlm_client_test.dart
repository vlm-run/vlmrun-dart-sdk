import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

import 'helpers.dart';

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

  group('VlmClient', () {
    test('creates instance with default values', () {
      expect(client, isNotNull);
    });

    test('uses provided bearer token', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models',
        MockResponse(
          body: '''
          {
            "object": "list",
            "data": []
          }
          ''',
        ),
      );

      await client.openai.models.list();

      final request = mockClient.requests.first;
      expect(
        request.headers['Authorization'],
        equals('Bearer test-token'),
      );
    });

    test('throws AuthenticationError on 401', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models',
        MockResponse(
          statusCode: 401,
          body: '''
          {
            "error": {
              "message": "Invalid authentication",
              "code": "invalid_auth"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.openai.models.list(),
        throwsA(isA<AuthenticationError>()),
      );
    });

    test('throws RateLimitError on 429', () async {
      mockClient.addResponse(
        'GET',
        '/v1/openai/models',
        MockResponse(
          statusCode: 429,
          body: '''
          {
            "error": {
              "message": "Too many requests",
              "code": "rate_limit_exceeded"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.openai.models.list(),
        throwsA(isA<RateLimitError>()),
      );
    });
  });
}
