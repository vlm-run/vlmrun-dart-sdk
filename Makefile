.PHONY: help install build test test-integration lint format format-check clean all analyze-pub

default: help;

help:
	@echo "Official VLM Run Dart SDK"
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  install             Install dependencies"
	@echo "  build               Generate JSON serialization code"
	@echo "  test                Run unit tests"
	@echo "  test-integration    Run integration tests (requires VLM_API_KEY)"
	@echo "  lint                Run static analysis"
	@echo "  format              Format code"
	@echo "  format-check        Check code formatting without modifying files"
	@echo "  clean               Remove generated and build artifacts"
	@echo "  all                 Run install, build, lint, format-check, and test"
	@echo "  analyze-pub         Run pub.dev scoring analysis locally (requires pana)"
	@echo ""

install: ## Install dependencies
	dart pub get

build: ## Generate JSON serialization code
	dart run build_runner build --delete-conflicting-outputs

test: ## Run unit tests (excludes integration tests)
	dart test --exclude-tags integration

test-integration: ## Run integration tests (requires VLM_API_KEY)
	dart test --tags integration

lint: ## Run static analysis
	dart analyze --fatal-infos --no-fatal-warnings

format: ## Format code
	dart format .

format-check: ## Check code formatting without modifying files
	dart format --set-exit-if-changed .

clean: ## Remove generated and build artifacts
	dart run build_runner clean
	rm -rf .dart_tool/

all: install build lint format-check test ## Run full CI pipeline locally

analyze-pub: ## Run pub.dev scoring analysis locally (requires pana)
	dart pub global run pana .
