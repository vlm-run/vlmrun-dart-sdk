# Contributing to VLM Run Dart SDK

Thank you for your interest in contributing! This guide will help you get started with development and testing.

## Development Setup

1. Clone the repository:

```bash
git clone https://github.com/vlm-run/vlmrun-dart-sdk.git
cd vlmrun-dart-sdk
```

2. Install dependencies:

```bash
dart pub get
```

3. Generate JSON serialization code (if needed):

```bash
dart run build_runner build
```

## Testing

The SDK has two types of tests:

- **Unit tests**: Fast, isolated tests that don't require API access
- **Integration tests**: End-to-end tests that require a valid API key

### Running Unit Tests

Run all unit tests (excludes integration tests by default):

```bash
dart test
```

### Running Integration Tests

Integration tests require the `VLM_API_KEY` environment variable. Optionally set `VLM_BASE_URL` to override the default API endpoint.

Run all integration tests:

```bash
VLM_API_KEY=your-api-key dart test --tags integration
```

Run with a custom base URL (e.g., for staging/dev environment):

```bash
VLM_API_KEY=your-api-key VLM_BASE_URL=https://dev.vlm.run dart test --tags integration
VLM_API_KEY=your-api-key VLM_AGENT_BASE_URL=https://dev-agent.vlm.run dart test --tags integration
```

### Targeting Specific Tests

Use the `--name` (or `-n`) flag with a regex pattern to run specific tests:

```bash
# Run a specific test by name
dart test --tags integration --name "generates prediction from image URL"

# Run tests matching a partial name
dart test --tags integration -n "from image URL"

# Run all tests in a specific group
dart test --tags integration -n "Image Predictions"

# Run tests in nested groups
dart test --tags integration -n "README Examples Image Predictions"
```

### Running Tests in a Specific File

```bash
# Run all tests in a specific file
dart test test/resources/image_test.dart

# Run integration tests from a specific file
VLM_API_KEY=your-api-key dart test test/integration/readme_examples_test.dart
```

### Test Structure

```
test/
├── helpers.dart              # Shared test utilities
├── vlm_client_test.dart      # Client initialization tests
├── integration/              # Integration tests (require API key)
│   └── readme_examples_test.dart
└── resources/                # Unit tests for each resource
    ├── audio_test.dart
    ├── document_test.dart
    ├── files_test.dart
    ├── image_test.dart
    ├── models_test.dart
    ├── predictions_test.dart
    ├── schema_test.dart
    └── openai/
        ├── chat_completions_test.dart
        └── models_test.dart
```

### Writing Tests

- Tag integration tests with `@Tags(['integration'])` at the top of the file
- Use descriptive test names that explain what is being tested
- Follow existing patterns in the test files

Example integration test:

```dart
@Tags(['integration'])
import 'package:test/test.dart';

void main() {
  test('describes what the test does', () async {
    // Test implementation
  });
}
```

## Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format .` before committing
- Run `dart analyze` to check for issues

### pub.dev Scoring Analysis

To check how the package scores on pub.dev locally, run the `pana` analyzer:

```bash
make analyze-pub
```

This requires the `pana` tool. If it's not installed, activate it first:

```bash
dart pub global activate pana
```

Then run:

```bash
make analyze-pub
```

## Publishing to pub.dev

> Only maintainers with pub.dev publisher access can publish the package.

### Pre-publish checklist

1. Bump the version in `pubspec.yaml`.
2. Update `CHANGELOG.md` with the release notes for the new version.
3. Ensure all generated files are up-to-date:

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the full CI pipeline locally to confirm everything is green:

```bash
make all
```

### Dry run

Validate the package before publishing. This checks for issues without uploading anything:

```bash
dart pub publish --dry-run
```

Or via Make:

```bash
make publish-dry-run
```

### Publish

Once the dry run is clean and the PR is merged to `main`:

```bash
dart pub publish
```

Or via Make:

```bash
make publish
```

The command will prompt for confirmation and open a browser window for authentication if needed.

## Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Run tests to ensure everything passes
5. Commit your changes with a descriptive message
6. Push to your fork and create a pull request

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
