// ignore_for_file: avoid_print
import 'dart:io';

import 'package:vlmrun/vlmrun.dart';

/// Demonstrates the core features of the VLM Run Dart SDK.
///
/// Set the VLM_API_KEY environment variable before running:
///
/// ```bash
/// VLM_API_KEY=your-api-key dart run example/vlmrun_example.dart
/// ```
void main() async {
  final apiKey = Platform.environment['VLM_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    print('Error: VLM_API_KEY environment variable is not set.');
    exit(1);
  }

  final client = VlmRun(
    bearerToken: apiKey,
    timeout: const Duration(seconds: 120),
  );

  await exampleImagePrediction(client);
  await exampleDocumentPrediction(client);
  await exampleListModels(client);
  await exampleOpenAIChat(client);
}

/// Generates a structured prediction from a remote image URL.
Future<void> exampleImagePrediction(VlmRun client) async {
  print('\n--- Image Prediction ---');

  const imageUrl =
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

  print('Prediction ID : ${response.id}');
  print('Status        : ${response.status}');

  if (response.status != 'completed') {
    print('Waiting for completion...');
    final result = await client.predictions.wait(
      response.id,
      timeout: 120,
      sleep: 2,
    );
    print('Result        : ${result.response}');
  } else {
    print('Result        : ${response.response}');
  }
}

/// Uploads a local file and generates a document prediction.
Future<void> exampleDocumentPrediction(VlmRun client) async {
  print('\n--- Document Prediction ---');

  // Use any local PDF or image file here.
  final localFile = File('example/assets/invoice_sample.jpg');
  if (!localFile.existsSync()) {
    print('Skipping: example/assets/invoice_sample.jpg not found.');
    return;
  }

  final uploaded = await client.files.create(
    file: localFile,
    purpose: 'vision',
  );
  print('Uploaded file : ${uploaded.id}');

  final response = await client.document.generate(
    FilePredictionParams(
      fileId: uploaded.id,
      model: 'vlm-1',
      domain: 'document.invoice',
    ),
  );

  print('Prediction ID : ${response.id}');
  print('Status        : ${response.status}');

  if (response.status != 'completed') {
    print('Waiting for completion...');
    final result = await client.predictions.wait(
      response.id,
      timeout: 120,
      sleep: 2,
    );
    print('Result        : ${result.response}');
  } else {
    print('Result        : ${response.response}');
  }
}

/// Lists available models on the VLM Run platform.
Future<void> exampleListModels(VlmRun client) async {
  print('\n--- Available Models ---');

  final models = await client.models.list();
  for (final model in models.take(5)) {
    print('  ${model.domain}${model.model != null ? ' (${model.model})' : ''}');
  }
  if (models.length > 5) {
    print('  ... and ${models.length - 5} more');
  }
}

/// Sends a chat message using the OpenAI-compatible completions endpoint.
Future<void> exampleOpenAIChat(VlmRun client) async {
  print('\n--- OpenAI-Compatible Chat ---');

  final response = await client.openai.chat.create(
    messages: [
      ChatMessage(role: 'user', content: 'What can the VLM Run platform do?'),
    ],
    model: 'vlmrun-orion-1',
  );

  print('Reply: ${response.choices.first.message.content}');
}
