<div align="center">
<p align="center" style="width: 100%;">
    <img src="https://raw.githubusercontent.com/vlm-run/.github/refs/heads/main/profile/assets/vlm-black.svg" alt="VLM Run Logo" width="80" style="margin-bottom: -5px; color: #2e3138; vertical-align: middle; padding-right: 5px;"><br>
</p>
<h2>Dart SDK</h2>
<p align="center"><a href="https://docs.vlm.run"><b>Website</b></a> | <a href="https://app.vlm.run/"><b>Platform</b></a> | <a href="https://docs.vlm.run/"><b>Docs</b></a> | <a href="https://docs.vlm.run/blog"><b>Blog</b></a> | <a href="https://discord.gg/AMApC2UzVY"><b>Discord</b></a>
</p>
<p align="center">
<a href="https://pub.dev/packages/vlmrun"><img alt="pub.dev Version" src="https://img.shields.io/pub/v/vlmrun.svg"></a>
<a href="https://pub.dev/packages/vlmrun"><img alt="pub.dev Likes" src="https://img.shields.io/pub/likes/vlmrun"></a>
<a href="https://pub.dev/packages/vlmrun"><img alt="pub.dev Points" src="https://img.shields.io/pub/points/vlmrun"></a><br>
<a href="https://github.com/vlm-run/vlmrun-dart-sdk/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue"></a>
<a href="https://discord.gg/AMApC2UzVY"><img alt="Discord" src="https://img.shields.io/badge/discord-chat-purple?color=%235765F2&label=discord&logo=discord"></a>
<a href="https://twitter.com/vlmrun"><img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/vlmrun.svg?style=social&logo=twitter"></a>
</p>
</div>

The [VLM Run Dart SDK](https://pub.dev/packages/vlmrun) is the official Dart client for [VLM Run API platform](https://docs.vlm.run), providing a convenient way to interact with our REST APIs from Dart and Flutter applications.

## Getting Started

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  vlmrun: ^0.1.0
```

Then run:

```bash
dart pub get
```

### Basic Usage

### Image Predictions

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Process an image (using image url)
  final imageUrl = 'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/invoice_1.jpg';
  final response = await client.image.generate(
    images: [imageUrl],
    domain: 'document.invoice',
    jsonSchema: {
      'type': 'object',
      'properties': {
        'invoice_number': {'type': 'string'},
        'total_amount': {'type': 'number'},
      },
    },
  );
  print(response.response);
}
```

### Document Predictions

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Upload a document
  final file = await client.files.create(
    file: File('path/to/invoice.pdf'),
    purpose: 'vision',
  );

  // Process a document (using file id)
  final response = await client.document.generate(
    fileId: file.id,
    model: 'vlm-1',
    domain: 'document.invoice',
  );
  print(response.response);

  // Process a document (using url)
  final documentUrl = 'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/google_invoice.pdf';
  final response2 = await client.document.generate(
    url: documentUrl,
    model: 'vlm-1',
    domain: 'document.invoice',
  );
  print(response2.response);
}
```

### Audio Predictions

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Upload an audio file
  final file = await client.files.create(
    file: File('path/to/audio.mp3'),
    purpose: 'audio-input',
  );

  // Process audio (using file id)
  final response = await client.audio.generate(
    fileId: file.id,
    model: 'vlm-1',
    domain: 'audio.transcription',
  );
  print(response.response);
}
```

### Web Predictions

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Extract data from a web page
  final response = await client.web.generate(
    url: 'https://example.com/product-page',
    domain: 'web.product',
    mode: 'fast',
  );
  print(response.response);
}
```

### Using Callback URLs for Async Processing

VLM Run supports callback URLs for asynchronous processing. When you provide a callback URL, the API will send a webhook notification to your endpoint when the prediction is complete.

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Process a document with callback URL
  final url = 'https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice/google_invoice.pdf';
  final response = await client.document.generate(
    url: url,
    domain: 'document.invoice',
    batch: true, // Enable batch processing for async execution
    callbackUrl: 'https://your-webhook-endpoint.com/vlm-callback',
  );

  print(response.status); // "pending"
  print(response.id); // Use this ID to track the prediction
}
```

#### Webhook Payload

When the prediction is complete, VLM Run will send a POST request to your callback URL with the following payload:

```json
{
  "id": "pred_abc123",
  "status": "completed",
  "response": {
    "invoice_id": "INV-001",
    "total": 1250.0,
    "items": []
  },
  "created_at": "2024-01-15T10:30:00Z",
  "completed_at": "2024-01-15T10:30:45Z"
}
```

### Waiting for Predictions

You can use the `predictions.wait()` method to poll for async prediction completion:

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  final client = VlmRun(bearerToken: 'your-api-key');

  // Start an async prediction
  final response = await client.document.generate(
    url: 'https://example.com/document.pdf',
    domain: 'document.invoice',
    batch: true,
  );

  // Wait for completion (with timeout)
  final result = await client.predictions.wait(
    response.id!,
    timeout: 60, // seconds
    sleep: 1, // polling interval in seconds
  );
  print(result.response);
}
```

### OpenAI-Compatible Chat Completions

The VLM Run SDK provides OpenAI-compatible chat completions through the OpenAI endpoint.

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  // Initialize the client
  final client = VlmRun(bearerToken: 'your-api-key');

  // Use OpenAI-compatible chat completions
  final response = await client.openai.chatCompletions.create(
    messages: [
      ChatMessage(role: 'user', content: 'Hello! How can you help me today?'),
    ],
    model: 'vlm-1',
  );

  print(response.choices.first.message.content);
}
```

### Agent Operations

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  final client = VlmRun(bearerToken: 'your-api-key');

  // List available agents
  final agents = await client.agent.list();
  print(agents);

  // Get agent info
  final agentInfo = await client.agent.get(name: 'my-agent');
  print(agentInfo);

  // Execute an agent
  final execution = await client.agent.execute(
    name: 'my-agent',
    inputs: {'key': 'value'},
    batch: true,
  );
  print(execution);
}
```

### File Management

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  final client = VlmRun(bearerToken: 'your-api-key');

  // Upload a file
  final file = await client.files.create(
    file: File('path/to/file.pdf'),
    purpose: 'vision',
  );
  print('Uploaded file: ${file.id}');

  // List files
  final files = await client.files.list(purpose: 'vision', limit: 10);
  for (final f in files.data) {
    print('File: ${f.filename}');
  }

  // Retrieve a file
  final retrieved = await client.files.retrieve(file.id);
  print('Retrieved: ${retrieved.filename}');

  // Delete a file
  await client.files.delete(file.id);
  print('File deleted');

  // Generate presigned URL for upload
  final presigned = await client.files.generatePresignedUrl(
    filename: 'new-file.pdf',
    purpose: 'vision',
  );
  print('Presigned URL: ${presigned.url}');
}
```

### Feedback

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  final client = VlmRun(bearerToken: 'your-api-key');

  // Submit feedback for a prediction
  final feedback = await client.feedback.submit(
    requestId: 'pred_abc123',
    response: {'corrected_field': 'value'},
    notes: 'The invoice number was incorrect',
  );
  print(feedback);

  // Get feedback for an entity
  final feedbackList = await client.feedback.get(
    entityId: 'pred_abc123',
    type: 'request',
  );
  print(feedbackList);
}
```

### Hub and Domains

```dart
import 'package:vlmrun/vlmrun.dart';

void main() async {
  final client = VlmRun(bearerToken: 'your-api-key');

  // Get hub info
  final hubInfo = await client.hub.info();
  print(hubInfo);

  // List available domains
  final domains = await client.hub.listDomains();
  for (final domain in domains) {
    print('Domain: ${domain.name}');
  }

  // Get schema for a domain
  final schema = await client.hub.getSchema('document.invoice');
  print(schema);

  // Using domains resource
  final domainsList = await client.domains.list();
  print(domainsList);

  final domainSchema = await client.domains.getSchema('document.invoice');
  print(domainSchema);
}
```

## Features

- Type-safe API with full type definitions
- Support for all VLM Run REST API endpoints
- Built-in error handling and response parsing
- Configurable timeout options
- Async prediction support with polling
- OpenAI-compatible chat completions
- Agent operations
- File management with presigned URL support
- Feedback submission
- Hub and domain discovery

## API Resources

| Resource | Description |
|----------|-------------|
| `files` | Upload, list, retrieve, and delete files |
| `image` | Process images and extract structured data |
| `document` | Process documents (PDFs, etc.) |
| `audio` | Process audio files |
| `video` | Process video files |
| `web` | Extract data from web pages |
| `predictions` | List, get, and wait for predictions |
| `agent` | Agent operations and execution |
| `executions` | Manage agent executions |
| `feedback` | Submit and retrieve feedback |
| `hub` | Hub information and domain discovery |
| `domains` | Domain listing and schema retrieval |
| `openai` | OpenAI-compatible chat completions |
| `models` | List available models |

## Authentication

To use the VLM Run API, you'll need an API key. You can obtain one by:

1. Create an account at [VLM Run](https://app.vlm.run)
2. Navigate to dashboard Settings -> API Keys

Then use it to initialize the client:

```dart
final client = VlmRun(bearerToken: 'your-api-key');
```

While you can provide a `bearerToken` directly in the constructor, we recommend using environment variables or secure configuration management for production applications.

## Documentation

For detailed documentation and API reference, visit our [documentation site](https://docs.vlm.run).

## Development

To generate the JSON serialization code:

```bash
dart run build_runner build
```

To run tests:

```bash
dart test
```

To analyze the code:

```bash
dart analyze
```

## Contributing

We welcome contributions! Please check out our repository for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
