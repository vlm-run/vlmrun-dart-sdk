import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

import '../helpers.dart';

void main() {
  late MockHttpClient mockClient;
  late Vlmrun client;

  setUp(() {
    mockClient = MockHttpClient();
    client = Vlmrun(
      bearerToken: 'test-token',
      httpClient: mockClient,
    );
  });

  group('Models', () {
    test('lists models successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/models',
        MockResponse(
          statusCode: 200,
          body: '''
          [
            {
              "domain": "document.generative",
              "model": "vlm-1"
            },
            {
              "domain": "document.pdf",
              "model": "vlm-1"
            }
          ]
          ''',
        ),
      );

      final response = await client.models.list();

      expect(response.length, equals(2));
      expect(response[0].domain, equals('document.generative'));
      expect(response[0].model, equals('vlm-1'));
      expect(response[1].domain, equals('document.pdf'));
      expect(response[1].model, equals('vlm-1'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'GET',
        '/v1/models',
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
        () => client.models.list(),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
