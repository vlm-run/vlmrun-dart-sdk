# Vlm Dart API library

The Vlm Dart library provides convenient access to the Vlm REST API from any Dart application. The library includes type definitions for all request params and response fields, and offers a clean, type-safe API for interacting with Vlm services.

## Installation

```yaml
dependencies:
  vlm: ^0.1.0
```

## Usage

```dart
import 'package:vlm/vlm.dart';

void main() async {
  final client = Vlm(bearerToken: 'your-token');
  
  final completion = await client.openai.chatCompletions.create(
    messages: [
      ChatMessage(role: 'user', content: 'Hello!'),
    ],
  );
  
  print(completion.id);
}
```

While you can provide a `bearerToken` directly in the constructor, we recommend using environment variables or secure configuration management for production applications.

## Features

- Type-safe API with full type definitions
- Support for all Vlm REST API endpoints
- Built-in error handling and response parsing
- Configurable timeout and retry options
- Comprehensive documentation

## API

### DocumentResource

- **generate**  
  Generates a document based on provided parameters.  
  **Parameters:**  
  - `fileId`: Required. The ID of the file to generate the document for.  
  - `id`: Optional. The ID for the document.  
  - `callbackUrl`: Optional. URL to call back after document generation.  
  - `createdAt`: Optional. The creation date of the document.  
  - `detail`: Optional. Details for the document generation (default: 'auto').  
  - `domain`: Optional. The domain for the document.

### FilesResource

- **create**  
  Creates a file with optional purpose.  
  **Parameters:**  
  - `file`: Required. The file to create.  
  - `purpose`: Optional. The purpose of the file.  

- **list**  
  Lists files with optional filters.  
  **Parameters:**  
  - `purpose`: Optional. Filter files by purpose.  
  - `limit`: Optional. Limit the number of files returned.  
  - `after`: Optional. Return files after a certain point.  
  - `order`: Optional. Order of the returned files.

- **retrieve**  
  Retrieves a file by its ID.  
  **Parameters:**  
  - `fileId`: Required. The ID of the file to retrieve.

### SchemaResource

- **generate**  
  Generates a schema prediction based on a prompt and schema.  
  **Parameters:**  
  - `prompt`: Required. The prompt for the prediction.  
  - `schema`: Required. The schema to use for prediction.  
  - `model`: Optional. The model to use for prediction.  
  - `options`: Optional. Additional options for the prediction.

### ChatCompletion

Contains fields for chat completion responses.  

- `id`: The ID of the chat completion.  
- `object`: The type of object returned.  
- `created`: The timestamp when the chat completion was created.  
- `model`: The model used for the chat completion.  
- `choices`: The choices returned by the chat completion.  
- `usage`: The usage information for the chat completion.  

## Documentation

The REST API documentation can be found on [vlm.run](https://vlm.run/).

## Development

To generate the JSON serialization code:

```bash
dart run build_runner build
```

## License

MIT License
