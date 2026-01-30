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

  group('Predictions', () {
    test('lists predictions successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/predictions',
        MockResponse(
          body: '''
          [
            {
              "id": "pred_123",
              "created_at": "2024-01-15T10:30:00Z",
              "status": "completed",
              "response": {"invoice_id": "INV-001"}
            },
            {
              "id": "pred_456",
              "created_at": "2024-01-15T10:31:00Z",
              "status": "pending"
            }
          ]
          ''',
        ),
      );

      final predictions = await client.predictions.list();

      expect(predictions.length, equals(2));
      expect(predictions[0].id, equals('pred_123'));
      expect(predictions[0].status, equals('completed'));
      expect(predictions[1].id, equals('pred_456'));
      expect(predictions[1].status, equals('pending'));
    });

    test('lists predictions with pagination', () async {
      // Note: MockHttpClient matches on url.path which doesn't include query params
      mockClient.addResponse(
        'GET',
        '/v1/predictions',
        MockResponse(
          body: '''
          [
            {
              "id": "pred_789",
              "created_at": "2024-01-15T10:30:00Z",
              "status": "completed"
            }
          ]
          ''',
        ),
      );

      final predictions = await client.predictions.list(skip: 10, limit: 5);

      expect(predictions.length, equals(1));
      expect(predictions[0].id, equals('pred_789'));
    });

    test('gets prediction by id successfully', () async {
      mockClient.addResponse(
        'GET',
        '/v1/predictions/pred_123',
        MockResponse(
          body: '''
          {
            "id": "pred_123",
            "created_at": "2024-01-15T10:30:00Z",
            "completed_at": "2024-01-15T10:30:45Z",
            "status": "completed",
            "response": {
              "invoice_id": "INV-001",
              "total": 1250.0
            }
          }
          ''',
        ),
      );

      final prediction = await client.predictions.get('pred_123');

      expect(prediction.id, equals('pred_123'));
      expect(prediction.status, equals('completed'));
      expect(prediction.response?['invoice_id'], equals('INV-001'));
      expect(prediction.response?['total'], equals(1250.0));
    });

    test('throws error for empty id', () async {
      expect(
        () => client.predictions.get(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('handles error responses for get', () async {
      mockClient.addResponse(
        'GET',
        '/v1/predictions/invalid_id',
        MockResponse(
          statusCode: 404,
          body: '''
          {
            "error": {
              "code": "not_found",
              "message": "Prediction not found"
            }
          }
          ''',
        ),
      );

      expect(
        () => client.predictions.get('invalid_id'),
        throwsA(isA<NotFoundError>()),
      );
    });

    test('wait returns completed prediction immediately', () async {
      mockClient.addResponse(
        'GET',
        '/v1/predictions/pred_123',
        MockResponse(
          body: '''
          {
            "id": "pred_123",
            "created_at": "2024-01-15T10:30:00Z",
            "completed_at": "2024-01-15T10:30:45Z",
            "status": "completed",
            "response": {"result": "done"}
          }
          ''',
        ),
      );

      final result = await client.predictions.wait('pred_123', timeout: 5);

      expect(result.id, equals('pred_123'));
      expect(result.status, equals('completed'));
    });
  });
}
