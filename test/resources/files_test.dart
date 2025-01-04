import 'dart:io';
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

  group('Files', () {
    test('creates file successfully', () async {
      // Create a temporary file for testing
      final tempDir = Directory.systemTemp.createTempSync();
      final file = File('${tempDir.path}/test.txt')
        ..writeAsStringSync('test content');

      mockClient.addResponse(
        'POST',
        '/v1/files',
        MockResponse(
          body: '''
          {
            "id": "file-123",
            "object": "file",
            "bytes": 1024,
            "created_at": "2025-01-02T15:46:57Z",
            "filename": "test.txt",
            "purpose": "audio-input"
          }
          ''',
        ),
      );

      final response = await client.files.create(
        file: file,
        purpose: 'audio-input',
      );

      expect(response.id, equals('file-123'));
      expect(response.object, equals('file'));
      expect(response.bytes, equals(1024));
      expect(response.createdAt?.toIso8601String(),
          equals('2025-01-02T15:46:57.000Z'));
      expect(response.filename, equals('test.txt'));
      expect(response.purpose, equals('audio-input'));

      // Cleanup
      tempDir.deleteSync(recursive: true);
    });

    test('lists files successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/files', // The query parameters will be added automatically
        MockResponse(
          body: '''
          [
            {
              "id": "file-123",
              "object": "file",
              "bytes": 1024,
              "created_at": "2025-01-02T15:46:57Z",
              "filename": "test1.txt",
              "purpose": "audio-input"
            },
            {
              "id": "file-456",
              "object": "file",
              "bytes": 2048,
              "created_at": "2025-01-02T15:46:58Z",
              "filename": "test2.txt",
              "purpose": "audio-input"
            }
          ]
          ''',
        ),
      );

      final response = await client.files.list(limit: 10);

      expect(response.length, equals(2));
      expect(response[0].id, equals('file-123'));
      expect(response[0].bytes, equals(1024));
      expect(response[0].createdAt?.toIso8601String(),
          equals('2025-01-02T15:46:57.000Z'));
      expect(response[0].filename, equals('test1.txt'));
      expect(response[0].purpose, equals('audio-input'));
    });

    test('handles file not found error', () async {
      mockClient.addResponse(
        'GET',
        '/v1/files/nonexistent',
        MockResponse(
          statusCode: 404,
          body: '''
          {
            "error": {
              "message": "No such file",
              "type": "invalid_request_error",
              "param": null,
              "code": null
            }
          }''',
        ),
      );

      expect(
        () => client.files.retrieve('nonexistent'),
        throwsA(isA<NotFoundError>()),
      );
    });
  });
}
