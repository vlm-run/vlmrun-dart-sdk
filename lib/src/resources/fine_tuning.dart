import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/fine_tuning.dart';
import '../utils/http_utils.dart';

/// Resource class for fine-tuning-related endpoints.
class FineTuningResource {
  FineTuningResource(this._client);

  final VlmRun _client;

  /// Create a fine-tuning job.
  ///
  /// [model] - Base model to fine-tune
  /// [trainingFile] - File ID for training data
  /// [validationFile] - File ID for validation data
  /// [numEpochs] - Number of training epochs (default: 1)
  /// [batchSize] - Batch size for training (default: "auto")
  /// [learningRate] - Learning rate (default: 2e-4)
  /// [suffix] - Suffix for the fine-tuned model
  /// [wandbApiKey] - Weights & Biases API key
  /// [wandbBaseUrl] - Weights & Biases base URL
  /// [wandbProjectName] - Weights & Biases project name
  Future<FinetuningResponse> create({
    required String model,
    required String trainingFile,
    String? validationFile,
    int numEpochs = 1,
    dynamic batchSize = 'auto',
    double learningRate = 2e-4,
    String? suffix,
    String? wandbApiKey,
    String? wandbBaseUrl,
    String? wandbProjectName,
  }) async {
    final data = <String, dynamic>{
      'model': model,
      'training_file': trainingFile,
      'num_epochs': numEpochs,
      'batch_size': batchSize,
      'learning_rate': learningRate,
    };
    if (validationFile != null) data['validation_file'] = validationFile;
    if (suffix != null) data['suffix'] = suffix;
    if (wandbApiKey != null) data['wandb_api_key'] = wandbApiKey;
    if (wandbBaseUrl != null) data['wandb_base_url'] = wandbBaseUrl;
    if (wandbProjectName != null) {
      data['wandb_project_name'] = wandbProjectName;
    }

    final response = await _client.request(
      'POST',
      '/v1/fine_tuning/create',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return FinetuningResponse.fromJson(json);
  }

  /// Provision a fine-tuned model.
  ///
  /// [model] - Model to provision
  /// [duration] - Duration in seconds (default: 600)
  /// [concurrency] - Concurrency level (default: 1)
  Future<FinetuningProvisionResponse> provision({
    required String model,
    int duration = 600,
    int concurrency = 1,
  }) async {
    final data = <String, dynamic>{
      'model': model,
      'duration': duration,
      'concurrency': concurrency,
    };

    final response = await _client.request(
      'POST',
      '/v1/fine_tuning/provision',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return FinetuningProvisionResponse.fromJson(json);
  }

  /// List fine-tuning jobs.
  Future<List<FinetuningResponse>> list({
    int? skip,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (skip != null) queryParams['skip'] = skip.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    var path = '/v1/fine_tuning';
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
            (item) => FinetuningResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Get fine-tuning job by ID.
  Future<FinetuningResponse> get(String jobId) async {
    if (jobId.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `jobId`');
    }

    final response = await _client.request('GET', '/v1/fine_tuning/$jobId');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return FinetuningResponse.fromJson(json);
  }
}
