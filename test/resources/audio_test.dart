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

  group('Audio', () {
    test('generates audio prediction successfully', () async {
      mockClient.addResponse(
        'POST',
        '/v1/audio/generate',
        MockResponse(
          body: '''
          {
            "id": "123",
            "created_at": "2019-12-27T18:11:19.117Z",
            "completed_at": "2019-12-27T18:11:19.117Z",
            "response": {
              "model": "vlm-1",
              "domain": "audio.transcription",
              "output": {
                "text": "Hello, world!"
              }
            },
            "status": "completed"
          }
          ''',
        ),
      );

      final response = await client.audio.generate(
        id: 'id',
        batch: true,
        callbackUrl: 'https://example.com',
        createdAt: DateTime.parse('2019-12-27T18:11:19.117Z'),
        domain: 'audio.transcription',
        fileId: 'file_id',
        metadata: AudioMetadata(
          allowTraining: true,
          environment: 'dev',
          sessionId: 'session_id',
        ),
        model: 'vlm-1',
        url: 'url',
      );

      expect(response.id, equals('123'));
      expect(response.status, equals('completed'));
      expect(response.response?['model'], equals('vlm-1'));
      expect(response.response?['domain'], equals('audio.transcription'));
      expect(response.response?['output']?['text'], equals('Hello, world!'));
    });

    test('handles error responses', () async {
      mockClient.addResponse(
        'POST',
        '/v1/audio/generate',
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
        () => client.audio.generate(fileId: ''),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('handles error responses for audio generate endpoint', () async {
      mockClient.addResponse(
        'POST',
        '/v1/audio/generate',
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
        () => client.audio.generate(fileId: ''),
        throwsA(isA<BadRequestError>()),
      );
    });
  });
}
