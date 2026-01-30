import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/shared/prediction_response.dart';
import '../types/generation_config.dart';
import '../types/request_metadata.dart';
import '../utils/http_utils.dart';

/// Exception thrown when a prediction times out.
class RequestTimeoutError implements Exception {
  RequestTimeoutError(this.message);
  final String message;

  @override
  String toString() => 'RequestTimeoutError: $message';
}

/// Exception thrown for input validation errors.
class InputError implements Exception {
  InputError(this.message, {this.code, this.suggestion});
  final String message;
  final String? code;
  final String? suggestion;

  @override
  String toString() => 'InputError: $message';
}

/// Parameters for listing predictions.
class ListParams {
  const ListParams({this.skip, this.limit});
  final int? skip;
  final int? limit;
}

/// Parameters for image predictions.
class ImagePredictionParams {
  const ImagePredictionParams({
    this.images,
    this.urls,
    this.model = 'vlm-1',
    required this.domain,
    this.batch = false,
    this.config,
    this.metadata,
    this.callbackUrl,
  });

  final List<String>? images;
  final List<String>? urls;
  final String model;
  final String domain;
  final bool batch;
  final GenerationConfig? config;
  final RequestMetadata? metadata;
  final String? callbackUrl;
}

/// Parameters for file-based predictions (document, audio, video).
class FilePredictionParams {
  const FilePredictionParams({
    this.fileId,
    this.url,
    this.model = 'vlm-1',
    required this.domain,
    this.batch = false,
    this.config,
    this.metadata,
    this.callbackUrl,
  });

  final String? fileId;
  final String? url;
  final String model;
  final String domain;
  final bool batch;
  final GenerationConfig? config;
  final RequestMetadata? metadata;
  final String? callbackUrl;
}

/// Parameters for file execute operations.
class FileExecuteParams {
  const FileExecuteParams({
    required this.name,
    this.version = 'latest',
    this.fileId,
    this.url,
    this.batch = true,
    this.config,
    this.metadata,
    this.callbackUrl,
  });

  final String name;
  final String version;
  final String? fileId;
  final String? url;
  final bool batch;
  final GenerationConfig? config;
  final RequestMetadata? metadata;
  final String? callbackUrl;
}

/// Base resource class for prediction-related endpoints.
class PredictionsResource {
  PredictionsResource(this._client);

  final VlmRun _client;

  /// List all predictions.
  Future<List<PredictionResponse>> list({
    int? skip,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (skip != null) queryParams['skip'] = skip.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    var path = '/v1/predictions';
    if (queryParams.isNotEmpty) {
      final uri = Uri.parse(path).replace(queryParameters: queryParams);
      path = uri.toString();
    }

    final response = await _client.request('GET', path);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map(
            (item) => PredictionResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Get a prediction by ID.
  Future<PredictionResponse> get(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `id`');
    }

    final response = await _client.request('GET', '/v1/predictions/$id');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }

  /// Wait for a prediction to complete.
  ///
  /// [id] - ID of prediction to wait for
  /// [timeout] - Timeout in seconds (default: 60)
  /// [sleep] - Sleep time in seconds between checks (default: 1)
  Future<PredictionResponse> wait(
    String id, {
    int timeout = 60,
    int sleep = 1,
  }) async {
    final startTime = DateTime.now();
    final timeoutDuration = Duration(seconds: timeout);

    while (DateTime.now().difference(startTime) < timeoutDuration) {
      final response = await get(id);
      if (response.status == 'completed') {
        return response;
      }
      await Future.delayed(Duration(seconds: sleep));
    }

    throw RequestTimeoutError(
      'Prediction $id did not complete within $timeout seconds',
    );
  }
}

/// Resource class for image prediction endpoints.
class ImagePredictionsResource extends PredictionsResource {
  ImagePredictionsResource(super.client);

  /// Handle images and URLs input validation and processing.
  List<String> _handleImagesOrUrls(List<String>? images, List<String>? urls) {
    if (images == null && urls == null) {
      throw InputError(
        'Either `images` or `urls` must be provided',
        code: 'missing_parameter',
        suggestion: 'Provide either images or urls parameter',
      );
    }
    if (images != null && urls != null) {
      throw InputError(
        'Only one of `images` or `urls` can be provided',
        code: 'invalid_parameters',
        suggestion: 'Provide either images or urls, not both',
      );
    }

    if (images != null) {
      if (images.isEmpty) {
        throw InputError(
          'Images array cannot be empty',
          code: 'empty_array',
          suggestion: 'Provide at least one image',
        );
      }
      return images;
    } else if (urls != null) {
      if (urls.isEmpty) {
        throw InputError(
          'URLs array cannot be empty',
          code: 'empty_array',
          suggestion: 'Provide at least one URL',
        );
      }
      if (!urls.every((url) => url.startsWith('http'))) {
        throw InputError(
          "URLs must start with 'http'",
          code: 'invalid_format',
          suggestion: 'Ensure all URLs start with http or https',
        );
      }
      return urls;
    }

    throw InputError(
      'Either `images` or `urls` must be provided',
      code: 'missing_parameter',
      suggestion: 'Provide either images or urls parameter',
    );
  }

  /// Generate predictions from images.
  ///
  /// [params.images] - Array of image inputs (file paths or base64 encoded strings)
  /// [params.urls] - Array of URL strings pointing to images
  /// [params.model] - Model ID to use for prediction (default: 'vlm-1')
  /// [params.domain] - Domain for the prediction (e.g., 'document.invoice')
  /// [params.batch] - Whether to process as batch (default: false)
  /// [params.config] - Configuration options for the prediction
  /// [params.metadata] - Additional metadata to include
  /// [params.callbackUrl] - URL to receive prediction completion webhook
  Future<PredictionResponse> generate(ImagePredictionParams params) async {
    final imagesData = _handleImagesOrUrls(params.images, params.urls);

    final body = <String, dynamic>{
      'images': imagesData,
      'model': params.model,
      'domain': params.domain,
      'batch': params.batch,
      'config': {
        'detail': params.config?.detail ?? 'auto',
        'json_schema': params.config?.jsonSchema,
        'confidence': params.config?.confidence ?? false,
        'grounding': params.config?.grounding ?? false,
        'gql_stmt': params.config?.gqlStmt,
      },
      'metadata': {
        'environment': params.metadata?.environment ?? 'dev',
        'session_id': params.metadata?.sessionId,
        'allow_training': params.metadata?.allowTraining ?? true,
      },
      if (params.callbackUrl != null) 'callback_url': params.callbackUrl,
    };

    final response = await _client.request(
      'POST',
      '/v1/image/generate',
      body: jsonEncode(body),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }

  /// Auto-generate a schema for a given image.
  ///
  /// [images] - Array of image inputs (file paths or base64 encoded strings)
  /// [urls] - Array of URL strings pointing to images
  Future<PredictionResponse> schema({
    List<String>? images,
    List<String>? urls,
  }) async {
    final imagesData = _handleImagesOrUrls(images, urls);

    final body = <String, dynamic>{
      'images': imagesData,
    };

    final response = await _client.request(
      'POST',
      '/v1/image/schema',
      body: jsonEncode(body),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }
}

/// Resource class for file-based prediction endpoints (document, audio, video).
class FilePredictionsResource extends PredictionsResource {
  FilePredictionsResource(super.client, this._route);

  final String _route;

  /// Handle file or URL input validation.
  Map<String, String> _handleFileOrUrl(String? fileId, String? url) {
    if (fileId == null && url == null) {
      throw InputError(
        'Either `fileId` or `url` must be provided',
        code: 'missing_parameter',
        suggestion: 'Provide either a fileId or url parameter',
      );
    }
    if (fileId != null && url != null) {
      throw InputError(
        'Only one of `fileId` or `url` can be provided',
        code: 'invalid_parameters',
        suggestion: 'Provide either fileId or url, not both',
      );
    }

    return fileId != null ? {'file_id': fileId} : {'url': url!};
  }

  /// Generate predictions from files.
  ///
  /// [params.fileId] - File ID to use
  /// [params.url] - URL to use
  /// [params.model] - Model ID to use for prediction (default: 'vlm-1')
  /// [params.domain] - Domain for the prediction
  /// [params.batch] - Whether to process as batch (default: false)
  /// [params.config] - Configuration options for the prediction
  /// [params.metadata] - Additional metadata to include
  /// [params.callbackUrl] - URL to receive prediction completion webhook
  Future<PredictionResponse> generate(FilePredictionParams params) async {
    final fileOrUrl = _handleFileOrUrl(params.fileId, params.url);

    final body = <String, dynamic>{
      ...fileOrUrl,
      'model': params.model,
      'domain': params.domain,
      'batch': params.batch,
      'config': {
        'detail': params.config?.detail ?? 'auto',
        'json_schema': params.config?.jsonSchema,
        'confidence': params.config?.confidence ?? false,
        'grounding': params.config?.grounding ?? false,
        'gql_stmt': params.config?.gqlStmt,
      },
      'metadata': {
        'environment': params.metadata?.environment ?? 'dev',
        'session_id': params.metadata?.sessionId,
        'allow_training': params.metadata?.allowTraining ?? true,
      },
      if (params.callbackUrl != null) 'callback_url': params.callbackUrl,
    };

    final response = await _client.request(
      'POST',
      '/v1/$_route/generate',
      body: jsonEncode(body),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }

  /// Execute a named model/agent on files.
  ///
  /// [params.name] - Name of the model/agent to execute
  /// [params.version] - Version of the model/agent (default: 'latest')
  /// [params.fileId] - File ID to use
  /// [params.url] - URL to use
  /// [params.batch] - Whether to process as batch (default: true)
  /// [params.config] - Configuration options for the prediction
  /// [params.metadata] - Additional metadata to include
  /// [params.callbackUrl] - URL to receive prediction completion webhook
  Future<PredictionResponse> execute(FileExecuteParams params) async {
    final fileOrUrl = _handleFileOrUrl(params.fileId, params.url);

    final body = <String, dynamic>{
      'name': params.name,
      'version': params.version,
      ...fileOrUrl,
      'batch': params.batch,
      'config': {
        'detail': params.config?.detail ?? 'auto',
        'json_schema': params.config?.jsonSchema,
        'confidence': params.config?.confidence ?? false,
        'grounding': params.config?.grounding ?? false,
        'gql_stmt': params.config?.gqlStmt,
      },
      'metadata': {
        'environment': params.metadata?.environment ?? 'dev',
        'session_id': params.metadata?.sessionId,
        'allow_training': params.metadata?.allowTraining ?? true,
      },
      if (params.callbackUrl != null) 'callback_url': params.callbackUrl,
    };

    final response = await _client.request(
      'POST',
      '/v1/$_route/execute',
      body: jsonEncode(body),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }

  /// Auto-generate a schema for a given file.
  ///
  /// [fileId] - File ID to generate schema from
  /// [url] - URL to generate schema from
  Future<PredictionResponse> schema({
    String? fileId,
    String? url,
  }) async {
    final fileOrUrl = _handleFileOrUrl(fileId, url);

    final response = await _client.request(
      'POST',
      '/v1/$_route/schema',
      body: jsonEncode(fileOrUrl),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }
}
