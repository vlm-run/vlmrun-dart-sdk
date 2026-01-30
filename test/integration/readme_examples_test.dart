@Tags(['integration'])
import 'dart:io';

import 'package:test/test.dart';
import 'package:vlmrun/vlmrun.dart';

/// Integration tests covering README code examples.
///
/// These tests require a valid VLM_API_KEY environment variable.
/// Optionally set VLM_BASE_URL to override the default API endpoint.
///
/// Run with: dart test --tags integration
/// Or with custom base URL: VLM_API_KEY=your-api-key VLM_BASE_URL=https://custom.api.url dart test --tags integration
void main() {
  final apiKey = Platform.environment['VLM_API_KEY'];
  final baseUrl =
      Platform.environment['VLM_BASE_URL'] ?? 'https://api.vlm.run/v1';
  final agentBaseUrl =
      Platform.environment['VLM_AGENT_BASE_URL'] ?? 'https://agent.vlm.run/v1';

  group('README Examples', () {
    late VlmRun client;

    setUpAll(() {
      if (apiKey == null || apiKey.isEmpty) {
        throw StateError(
          'VLM_API_KEY environment variable is required for integration tests.\n'
          'Run with: VLM_API_KEY=your-api-key dart test --tags integration',
        );
      }
      client = VlmRun(
        bearerToken: apiKey,
        baseUrl: baseUrl,
        timeout: const Duration(seconds: 120),
      );
    });

    group('Image Predictions', () {
      test('generates prediction from image URL', () async {
        // README example: Image Predictions
        final imageUrl =
            'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/invoice_1.jpg';
        final response = await client.image.generate(
          ImagePredictionParams(
            urls: [imageUrl],
            domain: 'document.invoice',
            config: GenerationConfig(
              jsonSchema: {
                'type': 'object',
                'properties': {
                  'invoice_number': {'type': 'string'},
                  'total_amount': {'type': 'number'},
                },
              },
            ),
          ),
        );

        expect(response.id, isNotNull);
        expect(response.status, isIn(['completed', 'pending']));
      });
    });

    group('Document Predictions', () {
      test('generates prediction from document file', () async {
        // README example: Document Predictions
        // Upload a sample invoice file from assets
        final invoiceFile = File('test/integration/assets/invoice_sample.jpg');
        expect(invoiceFile.existsSync(), isTrue,
            reason: 'Sample invoice file should exist in assets');

        // Upload the file
        final uploadedFile = await client.files.create(
          file: invoiceFile,
          purpose: 'vision',
        );

        expect(uploadedFile.id, isNotNull);

        // Generate prediction from the uploaded file
        final response = await client.document.generate(
          FilePredictionParams(
            fileId: uploadedFile.id,
            model: 'vlm-1',
            domain: 'document.invoice',
          ),
        );

        expect(response.id, isNotNull);
        expect(response.status, isIn(['completed', 'pending']));
      });
    });

    group('Async Processing with Batch Mode', () {
      test('generates prediction with batch mode', () async {
        // README example: Using Callback URLs for Async Processing
        final imageUrl =
            'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/invoice_1.jpg';
        final response = await client.image.generate(
          ImagePredictionParams(
            urls: [imageUrl],
            domain: 'document.invoice',
          ),
        );

        expect(response.id, isNotNull);
        expect(response.status, isIn(['completed', 'pending']));
      });
    });

    group('OpenAI-Compatible Chat Completions', () {
      test('creates chat completion', () async {
        // README example: OpenAI-Compatible Chat Completions
        final client = VlmRun(
          bearerToken: apiKey!,
          baseUrl: agentBaseUrl,
          timeout: const Duration(seconds: 120),
        );
        final response = await client.openai.chat.create(
          messages: [
            ChatMessage(
                role: 'user', content: 'Hello! How can you help me today?'),
          ],
          model: 'vlmrun-orion-1',
        );

        expect(response.id, isNotNull);
        expect(response.choices, isNotEmpty);
        expect(response.choices.first.message.content, isNotNull);
      });
    });

    group('Predictions Resource', () {
      test('lists predictions', () async {
        final predictions = await client.predictions.list(limit: 5);

        expect(predictions, isA<List<PredictionResponse>>());
      });

      test('gets prediction by id', () async {
        // First create a prediction
        final imageUrl =
            'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/invoice_1.jpg';
        final created = await client.image.generate(
          ImagePredictionParams(
            urls: [imageUrl],
            domain: 'document.invoice',
          ),
        );

        expect(created.id, isNotNull);

        // Then retrieve it
        final retrieved = await client.predictions.get(created.id);

        expect(retrieved.id, equals(created.id));
      });

      test('waits for prediction to complete', () async {
        // README example: Waiting for Predictions
        final imageUrl =
            'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/invoice_1.jpg';
        final response = await client.image.generate(
          ImagePredictionParams(
            urls: [imageUrl],
            domain: 'document.invoice',
          ),
        );

        expect(response.id, isNotNull);

        // Wait for completion (with timeout)
        final result = await client.predictions.wait(
          response.id,
          timeout: 120, // seconds
          sleep: 2, // polling interval in seconds
        );

        expect(result.status, equals('completed'));
        expect(result.response, isNotNull);
      });
    });

    group('Models Resource', () {
      test('lists available models', () async {
        final models = await client.models.list();

        expect(models, isNotEmpty);
      });
    });
  });
}
