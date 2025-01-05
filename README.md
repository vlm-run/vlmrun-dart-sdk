# Vlm Dart API library

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [API Resources](#api-resources)
  - [DocumentResource](#documentresource)
  - [FilesResource](#filesresource)
  - [SchemaResource](#schemaresource)
  - [ChatCompletion](#chatcompletion)
- [Error Handling](#error-handling)
- [Development](#development)
- [License](#license)

## Introduction

The Vlm Dart library provides convenient access to the Vlm REST API from any Dart application. The library includes type definitions for all request params and response fields, and offers a clean, type-safe API for interacting with Vlm services.

## Installation

To install the `vlmrun-dart` library, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  vlmrun:
    version: ^0.1.0
```

## Usage

Here is a simple example of how to use the `vlmrun` library:

```dart
import 'dart:io';
import 'package:vlmrun/vlmrun.dart';

Future<void> main() async {
  final client = VlmRun(
    bearerToken: Platform.environment['BEARER_TOKEN'] ?? '',
    baseUrl: 'https://dev.vlm.run',
  );

  const imageUrl =
      "https://storage.googleapis.com/vlm-data-public-prod/hub/examples/document.invoice-extraction/invoice_1.jpg";

  try {
    final response = await client.image.generate(
      image: imageUrl,
      domain: 'document.invoice',
      model: 'vlm-1',
    );

    print('Response: ${response.toJson()}');
  } catch (e) {
    print('Error: $e');
  }
}
```

While you can provide a `bearerToken` directly in the constructor, we recommend using environment variables or secure configuration management for production applications.

## Features

- **Type Safety**: The library provides type definitions for all request parameters and response fields.
- **Clean API**: Offers a clean and intuitive API for interacting with Vlm services.
- **Support for all Vlm REST API endpoints**: The library supports all endpoints of the Vlm REST API.
- **Built-in error handling and response parsing**: The library provides structured error handling and response parsing to manage API response errors effectively.
- **Configurable timeout and retry options**: The library allows you to configure timeout and retry options to suit your application's needs.
- **Comprehensive documentation**: The library is well-documented, making it easy to use and understand.

## API Resources

### DocumentResource

The `DocumentResource` class provides methods to interact with document-related endpoints of the Vlm API.

#### Methods

- **generate**: Generates a document prediction based on the provided parameters.

##### Parameters
- `fileId` (String): ID of the file to be processed.
- `domain` (String): The domain to which the document belongs.
- `model` (String): The model to be used for prediction.

##### Example
```dart
final response = await client.document.generate(
  fileId: '29577506-a882-44f4-a989-c5a653c1015f',
  domain: 'document.file',
  model: 'vlm-1',
);
print('Document prediction: ${response.toJson()}');
```

### FilesResource

The `FilesResource` class provides methods to interact with file-related endpoints of the Vlm API.

#### Methods

- **create**: Creates a new file in the Vlm system.

##### Parameters
- `fileName` (String): The name of the file to be created.
- `content` (String): The content of the file.

##### Example
```dart
final response = await client.files.create(
  fileName: 'example.txt',
  content: 'Hello, Vlm!',
);
print('File created: ${response.toJson()}');
```

- **list**: Lists files with optional filters.

##### Parameters
- `purpose`: Optional. Filter files by purpose.
- `limit`: Optional. Limit the number of files returned.
- `after`: Optional. Return files after a certain point.
- `order`: Optional. Order of the returned files.

##### Example
```dart
final response = await client.files.list(
  purpose: 'example',
  limit: 10,
);
print('Files: ${response.toJson()}');
```

- **retrieve**: Retrieves a file by its ID.

##### Parameters
- `fileId`: Required. The ID of the file to retrieve.

##### Example
```dart
final response = await client.files.retrieve(
  fileId: '12345',
);
print('File: ${response.toJson()}');
```

### SchemaResource

The `SchemaResource` class provides methods to interact with schema-related endpoints of the Vlm API.

#### Methods

- **generate**: Generates a schema prediction based on the provided parameters.

##### Parameters
- `schemaId` (String): The ID of the schema to be processed.

##### Example
```dart
final response = await client.schema.generate(
  schemaId: '12345',
);
print('Schema prediction: ${response.toJson()}');
```

### ChatCompletion

The `ChatCompletion` class provides methods to interact with chat-related endpoints of the Vlm API.

#### Methods

- **create**: Creates a chat completion based on the provided messages.

##### Parameters
- `messages` (List<ChatMessage>): A list of messages to be processed.

##### Example
```dart
final response = await client.chat.create(
  messages: [
    ChatMessage(role: 'user', content: 'Hello!'),
  ],
);
print('Chat response: ${response.toJson()}');
```

## Error Handling

The library provides structured error handling to manage API response errors effectively. Make sure to handle exceptions appropriately in your application.

## Development

To contribute to the development of `vlmrun-dart`, follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a description of your changes.

## License

This project is licensed under the MIT License.
