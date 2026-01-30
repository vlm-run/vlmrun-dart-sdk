# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Build
- `dart pub get` - Install dependencies
- `dart run build_runner build` - Generate JSON serialization code

### Testing
- `dart test` - Run unit tests (excludes integration tests)
- `dart test --tags integration` - Run integration tests (requires VLM_API_KEY)
- `dart test --name "test name"` - Run specific test by name pattern

### Linting & Analysis
- `dart analyze` - Run static analysis
- `dart format .` - Format code

## Project Architecture

### Core Structure
This is the official Dart SDK for the VLM Run API platform. The main entry point is `lib/vlmrun.dart` which exports the `VlmRun` class and all types.

### Client Architecture
The SDK follows a modular client pattern where each API resource has its own resource class:

- `VlmRun` class (lib/src/vlmrun_client.dart) - Main SDK entry point that initializes all sub-resources
- Resource classes in `lib/src/resources/`:
  - `ModelsResource` - Model listing and info
  - `FilesResource` - File upload/management
  - `PredictionsResource` - Prediction retrieval and polling
  - `ImageResource` - Image prediction generation
  - `DocumentResource` - Document prediction generation
  - `AudioResource` - Audio prediction generation
  - `VideoResource` - Video prediction generation
  - `SchemaResource` - Schema generation
  - `FeedbackResource` - Submit prediction feedback
  - `AgentResource` - Agent execution
  - `ExecutionsResource` - Execution management
  - `HubResource` - Hub and domain information
  - `DomainsResource` - Domain listing
  - `OpenAI` - OpenAI-compatible chat completions

### Key Features
- **Type Safety**: Full Dart type support with JSON serialization via json_annotation
- **File Handling**: Multipart file upload support
- **Error Handling**: Typed error classes (BadRequestError, AuthenticationError, NotFoundError, RateLimitError, InternalServerError)
- **Async Polling**: Built-in `predictions.wait()` method for async prediction completion

### Configuration
- Main client: `VlmRun` with bearerToken, baseUrl, timeout, httpClient parameters
- Default base URL: `https://api.vlm.run`
- Default timeout: 30 seconds

### Type Definitions
- Types are in `lib/src/types/` with JSON serialization via json_annotation
- Generated files have `.g.dart` suffix (created by build_runner)
- Shared types in `lib/src/types/shared/`

### Testing Strategy
- Unit tests in `test/resources/` mirror the resource structure
- Integration tests in `test/integration/` test real API interactions
- Mock HTTP client in `test/helpers.dart` for unit tests
- Integration tests require `VLM_API_KEY` environment variable

## Important Notes

- The SDK uses Dart 3.6+ with null safety
- JSON serialization code must be regenerated after modifying types: `dart run build_runner build`
- Integration tests are tagged with `@Tags(['integration'])` and excluded from default runs
- File uploads use multipart form-data requests
- All resource paths include `/v1/` prefix (base URL should not include it)
