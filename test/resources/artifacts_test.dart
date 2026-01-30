import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

import '../helpers.dart';

void main() {
  group('Artifacts', () {
    late VlmRun client;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      client = VlmRun(
        bearerToken: 'test-token',
        httpClient: mockHttpClient,
      );
    });

    test('get throws when neither sessionId nor executionId is provided', () {
      expect(
        () => client.artifacts.get(
          ArtifactGetParams(objectId: 'img_abc123'),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('get throws when both sessionId and executionId are provided', () {
      expect(
        () => client.artifacts.get(
          ArtifactGetParams(
            objectId: 'img_abc123',
            sessionId: 'session-1',
            executionId: 'exec-1',
          ),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('get returns bytes for image artifact with rawResponse', () async {
      final imageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);
      mockHttpClient.addResponse(
        'GET',
        '/v1/artifacts',
        MockResponse(
          body: String.fromCharCodes(imageBytes),
          statusCode: 200,
          headers: {'content-type': 'image/jpeg'},
        ),
      );

      final result = await client.artifacts.get(
        ArtifactGetParams(
          objectId: 'img_abc123',
          sessionId: 'session-1',
          rawResponse: true,
        ),
      );

      expect(result, isA<ArtifactBytesResponse>());
    });

    test('get returns bytes for image artifact', () async {
      final imageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);
      mockHttpClient.addResponse(
        'GET',
        '/v1/artifacts',
        MockResponse(
          body: String.fromCharCodes(imageBytes),
          statusCode: 200,
          headers: {'content-type': 'image/jpeg'},
        ),
      );

      final result = await client.artifacts.get(
        ArtifactGetParams(
          objectId: 'img_abc123',
          sessionId: 'session-1',
        ),
      );

      expect(result, isA<ArtifactBytesResponse>());
    });

    test('get throws on invalid object ID format', () async {
      mockHttpClient.addResponse(
        'GET',
        '/v1/artifacts',
        MockResponse(
          body: 'test data',
          statusCode: 200,
        ),
      );

      expect(
        () => client.artifacts.get(
          ArtifactGetParams(
            objectId: 'invalid',
            sessionId: 'session-1',
          ),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('get throws on invalid object ID suffix length', () async {
      mockHttpClient.addResponse(
        'GET',
        '/v1/artifacts',
        MockResponse(
          body: 'test data',
          statusCode: 200,
        ),
      );

      expect(
        () => client.artifacts.get(
          ArtifactGetParams(
            objectId: 'img_abc',
            sessionId: 'session-1',
          ),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('list throws UnimplementedError', () {
      expect(
        () => client.artifacts.list('session-1'),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('get uses executionId when provided', () async {
      final imageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);
      mockHttpClient.addResponse(
        'GET',
        '/v1/artifacts',
        MockResponse(
          body: String.fromCharCodes(imageBytes),
          statusCode: 200,
          headers: {'content-type': 'image/jpeg'},
        ),
      );

      final result = await client.artifacts.get(
        ArtifactGetParams(
          objectId: 'img_abc123',
          executionId: 'exec-1',
        ),
      );

      expect(result, isA<ArtifactBytesResponse>());

      // Verify the request was made with execution_id parameter
      final request = mockHttpClient.requests.last;
      expect(request.url.queryParameters['execution_id'], equals('exec-1'));
      expect(request.url.queryParameters['object_id'], equals('img_abc123'));
    });
  });
}
