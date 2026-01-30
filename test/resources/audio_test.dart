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
        FilePredictionParams(
          fileId: 'file_id',
          domain: 'audio.transcription',
          model: 'vlm-1',
          batch: true,
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
        () => client.audio.generate(
          FilePredictionParams(
            fileId: 'file_id',
            domain: 'audio.transcription',
          ),
        ),
        throwsA(isA<BadRequestError>()),
      );
    });

    test('throws InputError when neither fileId nor url provided', () {
      expect(
        () => client.audio.generate(
          FilePredictionParams(domain: 'audio.transcription'),
        ),
        throwsA(isA<InputError>()),
      );
    });

    test('throws InputError when both fileId and url provided', () {
      expect(
        () => client.audio.generate(
          FilePredictionParams(
            fileId: 'file_id',
            url: 'https://example.com/audio.mp3',
            domain: 'audio.transcription',
          ),
        ),
        throwsA(isA<InputError>()),
      );
    });
  });
}
