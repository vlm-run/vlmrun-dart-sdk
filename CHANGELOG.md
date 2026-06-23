# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.4] - 2026-06-23

### Added
- Added `pana` pub.dev scoring check to CI analysis job (non-blocking)

## [1.3.3] - 2026-06-23

### Added
- Added dartdoc comments to all public API elements (types, resources, fields)
- Documentation coverage now exceeds pub.dev's 20% threshold

## [1.3.2] - 2026-06-23

### Added
- Added `.pubignore` to exclude non-essential files from pub.dev publishing

### Fixed
- Added pub.dev token authentication before publish in release workflow

### Changed
- Renamed release workflow to `release-on-version-change`

## [1.3.1] - 2026-06-15

### Added
- Synced Dart SDK with Python SDK: added `skills`, `datasets`, and `fine_tuning` resources
- Added `getById` method to relevant resources
- Added missing type fields across models
- Added Makefile for development commands
- Added `.envrc` for environment variable configuration

### Fixed
- Fixed `fine_tuning` routes to match Python SDK
- Fixed chat completions to accept all 2xx responses
- Fixed integration test base URLs

## [1.0.2] - 2026-01-31

### Changed
- Renamed library from `vlm_sdk` to `vlmrun`
- Updated README with comprehensive documentation

### Removed
- Removed `web` resource and related types
- Removed `response` resource

## [1.0.1] - 2026-01-20

### Added
- Initial public release
- Support for image, document, audio, and video predictions
- OpenAI-compatible chat completions
- File upload and management
- Agent execution support
- Feedback submission
- Hub and domain discovery
- Predictions polling with `predictions.wait()`

## [0.1.0] - 2025-01-03

### Added
- Initial development release
